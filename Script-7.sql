create table if not exists Genre (
    id SERIAL primary key,
    denre VARCHAR(40) not null
);


create table if not exists Performer (
    id SERIAL primary key,
    name VARCHAR(40) not null
);


create table if not exists PerformerGenre (
    performer_id INTEGER references Performer(id),
    genre_id INTEGER references Genre(id),
    constraint pk primary key (performer_id, genre_id)
);


create table if not exists Album (
    id SERIAL primary key,
    name VARCHAR(128) not null
);


create table if not exists PerformerAlbum (
    performer_id INTEGER references Performer(id),
    album_id INTEGER references Album(id),
    constraint gs primary key (performer_id, album_id)
);


create table if not exists Track (
    id SERIAL primary key,
    album_id INTEGER not null references Album(id),
    track VARCHAR(80) not null,
    duration time not null
);


create table if not exists Collection (
    id SERIAL primary key,
    name VARCHAR(80) not null,
    release_year date not null
);

create table if not exists TrackCollection (
    track_id INTEGER references Track(id),
    collection_id INTEGER references Collection(id),
    constraint fd primary key (track_id, collection_id)
);
 
   
INSERT into genre(denre)
VALUES('Рок');

INSERT into genre(id, denre)
VALUES(2,'Поп');

INSERT into genre(id, denre)
VALUES(3,'Реп');

INSERT into performer (name)
VALUES('Любэ');

INSERT into performer (name)
VALUES('Руки Вверх');

INSERT into performer (name)
VALUES('Баста');

INSERT into performer (name)
VALUES('Полина Гагарина');

INSERT into performer (name)
VALUES('DEMAFRA');

DELETE FROM performer 
WHERE id = 5;

INSERT into album (name)
VALUES('Конь');

INSERT into album (name)
VALUES('Свое');

INSERT into album (name)
VALUES('Дышите равномерно');

INSERT into album (name)
VALUES('Сделай погромче');

INSERT into album (name)
VALUES('Баста 4');

INSERT into album (name)
VALUES('Баста 40');

INSERT into album (name)
VALUES('Выше головы');

INSERT into album (name)
VALUES('Попроси у облаков');

INSERT into track (album_id, track, duration)
VALUES(1,'Конь','0:3:37');

INSERT into track (album_id, track, duration)
VALUES(1,'А заря','0:2:44');

INSERT into track (album_id, track, duration)
VALUES(2,'Малыш', '0:3:51');

INSERT into track (album_id, track, duration)
VALUES(2,'Девчата', '0:4:15');

INSERT into track (album_id, track, duration)
VALUES(2,'Крошка моя', '0:2:17');

INSERT into track (album_id, track, duration)
VALUES(1,'Главное, что есть ты у меня', '0:3:46');

INSERT into track (album_id, track, duration)
VALUES(3,'Вселенная', '0:3:31');

INSERT into track (album_id, track, duration)
VALUES(3,'Белый кит', '0:5:19');

INSERT into track (album_id, track, duration)
VALUES(3,'Я или ты', '0:4:35');

INSERT into track (album_id, track, duration)
VALUES(4,'Выше головы', '0:3:57');

INSERT into track (album_id, track, duration)
VALUES(4,'Ты мой', '0:3:22');

INSERT into track (album_id, track, duration)
VALUES(4,'Ты не целуй', '0:4:03');

INSERT into collection (id, name, release_year)
VALUES(1,'Про любовь. Часть 1', '2018-02-01');

INSERT into collection (id, name, release_year)
VALUES(2, 'Король', '2020-02-01');

INSERT INTO collection (id, name, release_year)
VALUES(3, 'Газгольдер саунтрек', '2018-02-01');

INSERT INTO collection (id, name, release_year)
VALUES(4, 'Поэт Михаил Гуцериев "Особенные слова"', '2020-02-01');

INSERT INTO trackcollection (track_id, collection_id) 
VALUES(6, 1);

DELETE FROM trackcollection 
WHERE track_id = 1;

INSERT INTO trackcollection (track_id, collection_id)
VALUES(5, 2);

INSERT INTO trackcollection (track_id, collection_id)
VALUES(9, 3);

INSERT INTO trackcollection (track_id, collection_id)
VALUES(12, 4);

INSERT INTO performeralbum (performer_id, album_id)
VALUES(1, 1);

INSERT INTO performeralbum (performer_id, album_id)
VALUES(1, 2);

INSERT INTO performeralbum (performer_id, album_id)
VALUES(2, 3);

INSERT INTO performeralbum (performer_id, album_id)
VALUES(2, 4);

INSERT INTO performeralbum (performer_id, album_id)
VALUES(3, 5);

INSERT INTO performeralbum (performer_id, album_id) 
VALUES(3, 6);

INSERT INTO performeralbum (performer_id, album_id) 
VALUES(4, 7);

INSERT INTO performeralbum (performer_id, album_id) 
VALUES(4, 8);

INSERT INTO performergenre (performer_id, genre_id) 
VALUES(1, 1);

INSERT INTO performergenre (performer_id, genre_id)
VALUES(2, 2);

INSERT INTO performergenre (performer_id, genre_id)
VALUES(3, 3);

INSERT into performergenre (performer_id, genre_id)
VALUES(4, 2);


SELECT track, duration FROM track
ORDER BY duration desc
LIMIT 1;

SELECT track, duration FROM track
WHERE duration >= '0:3:30';

SELECT name, release_year FROM collection
WHERE release_year BETWEEN '2018-01-01' AND '2020-12-31';

SELECT name FROM performer
WHERE name NOT LIKE '% %';

SELECT track FROM track
WHERE track ILIKE 'мой %'
OR track ILIKE '% мой'
OR track ILIKE '% мой %'
OR track ILIKE 'мой';

SELECT COUNT(performer_id), genre_id FROM performergenre   
GROUP BY genre_id;

SELECT COUNT(track), release_year FROM track t
JOIN collection c ON t.id = c.id 
WHERE release_year BETWEEN '2019-01-01' AND '2020-12-31'
GROUP BY release_year;

SELECT AVG(duration), album_id FROM track
GROUP BY album_id;

SELECT p."name" , release_year FROM performer p 
JOIN performeralbum pa ON p.id = pa.album_id
JOIN trackcollection t ON pa.performer_id = t.collection_id 
JOIN collection c ON c.id = p.id 
WHERE release_year NOT BETWEEN '2020-01-01' AND '2020-12-31';  

SELECT  c."name", p."name" FROM collection c 
JOIN performeralbum pa ON c.id = pa.album_id
JOIN trackcollection t ON pa.performer_id = t.collection_id 
JOIN performer p ON c.id = p.id 
WHERE p."name" LIKE '%Гагарина%'; 


INSERT INTO track 
VALUES(13, 4, 'myself', '0:3:40'),
(14, 4, 'Oh my God', '0:3:45'),
(15, 4, 'Beemy', '0:3:05'),
(16, 4, 'my own','0:03:10'),
(17, 4, 'premyne', '0:04:0');

SELECT track FROM track
WHERE track ILIKE 'my %'
OR track ILIKE '% my'
OR track ILIKE '% my %'
OR track ILIKE 'my';

