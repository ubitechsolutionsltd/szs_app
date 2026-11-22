import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:simulizi/custom_code/player/player_core.dart';

PlayableItem item(int id, {String url = 'https://x/media/t'}) =>
    PlayableItem(id: id, title: 'Ep $id', remoteUrl: url);

PlayQueue queueOf(int count, {int start = 0, Random? random}) =>
    PlayQueue(random: random)..setItems([for (var i = 1; i <= count; i++) item(i)], startIndex: start);

void main() {
  group('PlayQueue auto-next', () {
    test('advances in order and stops after the last item', () {
      final q = queueOf(3);
      expect(q.current!.id, 1);
      expect(q.advanceOnComplete()!.id, 2);
      expect(q.advanceOnComplete()!.id, 3);
      expect(q.advanceOnComplete(), isNull);
      expect(q.current!.id, 3);
    });

    test('repeat one replays the same item, repeat all wraps around', () {
      final q = queueOf(2)..repeat = QueueRepeat.one;
      expect(q.advanceOnComplete()!.id, 1);
      q.repeat = QueueRepeat.all;
      expect(q.advanceOnComplete()!.id, 2);
      expect(q.advanceOnComplete()!.id, 1);
    });

    test('locked episodes (no link) are skipped by auto-next and next/previous', () {
      final q = PlayQueue()
        ..setItems([item(1), item(2, url: ''), item(3, url: ''), item(4)]);
      expect(q.advanceOnComplete()!.id, 4);
      expect(q.previous()!.id, 1);
    });

    test('downloaded episodes count as playable even without a link', () {
      final q = PlayQueue(isPlayable: (i) => i.hasRemoteUrl || i.id == 2)
        ..setItems([item(1), item(2, url: ''), item(3)]);
      expect(q.next()!.id, 2);
    });

    test('returns null when nothing playable follows', () {
      final q = PlayQueue()..setItems([item(1), item(2, url: '')]);
      expect(q.next(), isNull);
      expect(q.current!.id, 1);
    });
  });

  group('PlayQueue next / previous', () {
    test('next ignores repeat one', () {
      final q = queueOf(3)..repeat = QueueRepeat.one;
      expect(q.next()!.id, 2);
    });

    test('previous restarts after 3 seconds, otherwise goes back, and restarts at the start', () {
      final q = queueOf(3, start: 1);
      expect(q.previous(position: const Duration(seconds: 10))!.id, 2);
      expect(q.previous(position: const Duration(seconds: 1))!.id, 1);
      expect(q.previous(position: Duration.zero)!.id, 1);
    });

    test('jumpTo selects by original index', () {
      final q = queueOf(4);
      expect(q.jumpTo(2)!.id, 3);
      expect(q.jumpTo(9), isNull);
    });
  });

  group('PlayQueue shuffle', () {
    test('keeps the current item first and plays every item exactly once', () {
      final q = queueOf(6, start: 2, random: Random(7))..shuffle = true;
      expect(q.current!.id, 3);
      final seen = <int>[q.current!.id];
      PlayableItem? next;
      while ((next = q.advanceOnComplete()) != null) {
        seen.add(next!.id);
      }
      expect(seen.toSet(), {1, 2, 3, 4, 5, 6});
      expect(seen.length, 6);
    });

    test('turning shuffle off restores the original order from the current item', () {
      final q = queueOf(5, random: Random(3))..shuffle = true;
      q.advanceOnComplete();
      final here = q.current!.id;
      q.shuffle = false;
      expect(q.current!.id, here);
      expect(q.currentIndex, here - 1);
      expect(q.next()?.id, here < 5 ? here + 1 : null);
    });
  });

  group('PlayQueue editing', () {
    test('playNext inserts after the current item', () {
      final q = queueOf(3)..playNext(item(9));
      expect(q.advanceOnComplete()!.id, 9);
      expect(q.advanceOnComplete()!.id, 2);
    });

    test('removing items before the current one keeps the current item', () {
      final q = queueOf(4, start: 2);
      q.removeAt(0);
      expect(q.current!.id, 3);
      q.removeAt(q.currentIndex);
      expect(q.current!.id, 4);
    });

    test('removing the only item empties the queue', () {
      final q = queueOf(1)..removeAt(0);
      expect(q.current, isNull);
      expect(q.isEmpty, isTrue);
    });

    test('updateRemoteUrl swaps in a fresh link', () {
      final q = queueOf(2)..updateRemoteUrl(1, 'https://x/media/new');
      expect(q.current!.remoteUrl, 'https://x/media/new');
    });
  });

  group('MediaUrlPolicy', () {
    final now = DateTime.utc(2026, 1, 1, 12);
    String signed(DateTime expires) =>
        'https://szs.co.tz/public/api/media/abc?u=5&expires=${expires.millisecondsSinceEpoch ~/ 1000}&signature=zz';

    test('fresh signed links are kept, expiring or expired ones are refreshed', () {
      expect(MediaUrlPolicy.needsRefresh(signed(now.add(const Duration(hours: 1))), now: now), isFalse);
      expect(MediaUrlPolicy.needsRefresh(signed(now.add(const Duration(minutes: 2))), now: now), isTrue);
      expect(MediaUrlPolicy.needsRefresh(signed(now.subtract(const Duration(minutes: 1))), now: now), isTrue);
    });

    test('unsigned and empty links are never refreshed', () {
      expect(MediaUrlPolicy.needsRefresh('https://szs.co.tz/public/api/media/abc', now: now), isFalse);
      expect(MediaUrlPolicy.needsRefresh('', now: now), isFalse);
    });

    test('recognises signed and gate links', () {
      expect(MediaUrlPolicy.isSigned(signed(now)), isTrue);
      expect(MediaUrlPolicy.isGateUrl(signed(now)), isTrue);
      expect(MediaUrlPolicy.isGateUrl('https://cdn.example.com/a.mp3'), isFalse);
    });
  });

  group('helpers', () {
    test('resume position', () {
      expect(resumePositionFor(savedMs: 2000, durationMs: 600000), isNull);
      expect(resumePositionFor(savedMs: 120000, durationMs: 600000), const Duration(seconds: 120));
      expect(resumePositionFor(savedMs: 595000, durationMs: 600000), isNull);
      expect(resumePositionFor(savedMs: 120000, durationMs: 0), const Duration(seconds: 120));
    });

    test('file extension from content type', () {
      expect(extensionForContentType('audio/mp4'), 'm4a');
      expect(extensionForContentType('audio/mpeg; charset=x'), 'mp3');
      expect(extensionForContentType(null), 'mp3');
    });

    test('episode maps from the API and from structs both work', () {
      final api = PlayableItem.fromEpisodeMap({'id': 7, 'content_id': '3', 'name': 'N', 'audio': 'u', 'audio_duration': 90});
      final struct = PlayableItem.fromEpisodeMap({'id': '7', 'contentId': 3, 'name': 'N', 'audio': 'u', 'audioDuration': 90.0});
      expect(api.contentId, 3);
      expect(struct.durationSeconds, 90);
      expect(api, struct);
      expect(PlayableItem.fromJson(api.toJson()).remoteUrl, 'u');
    });
  });

  group('Playlist', () {
    test('add without duplicates, remove, reorder, rename, round trip', () {
      var p = const Playlist(id: 'p1', name: 'Mine');
      p = p.withItem(item(1), 1).withItem(item(2), 2).withItem(item(1), 3);
      expect(p.items.map((i) => i.id), [1, 2]);

      p = p.withItem(item(3), 4).reordered(2, 0, 5);
      expect(p.items.map((i) => i.id), [3, 1, 2]);

      p = p.withoutItem(1, 6).renamed('  Night  ', 7);
      expect(p.items.map((i) => i.id), [3, 2]);
      expect(p.name, 'Night');

      final back = Playlist.fromJson(p.toJson());
      expect(back.items.map((i) => i.id), [3, 2]);
      expect(back.updatedAtMs, 7);
    });
  });
}
