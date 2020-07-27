##### 1. release_date descending 순서대로 정렬, name, singer, album, release_date, genre
```
select name, singer, album, release_date, genre
from songs
order by  release_date DESC;
```
##### 2. release_date가 2020-07-01 이후에 발매 name, singer, album, release_date, genre
```
select name, singer, album, release_date, genre
from songs
where release_date>'2020-07-01'
order by  release_date DESC;
```
##### 3. release_date가 2020-07-01 이후에 발매되고 genre가 댄스 name, singer, album, release_date, genre
```
select name, singer, album, release_date, genre
from songs
where release_date>'2020-07-01' and genre='댄스'
order by  release_date DESC;
```
##### 4. 중복되지 않은 name 값 가져오기
```
select distinct name from songs;
```
##### 4.1 singer 별 row count
```
select count(*) from songs; # [output] 100
select singer, count(*) as cnt  # singer를 압축할 것=>group by
from songs group by singer
order by cnt desc;
```
##### 4.2 cnt 가 3곡 이상인 경우만 출력
```
select singer, count(*) as cnt  # singer 를 압축할 것=>group by
from songs
group by singer having cnt >= 3 # group by한 것에 대한 조건을 줄때에는 having
order by cnt desc;
```
##### 5. id 컬럼 수정(modify) - not null, auto_increment, primary key 
```
# 테이블 수정 => alt, alternate
# songs 테이블의 id 컬럼 수정, int, not null, 값 자동증가, primary key로 사용
alter table songs modify id int not null auto_increment primary key;
```
##### 6. insert
```
#insert into songs values() #id col은 자동증가로 안준다했으니 이렇게 쓰면 안됨
#select max(id) +1 from songs;
insert into songs (name,singer, album,release_date,genre,lyric)
    values('0330','ukiss','2015','2015-03-12','발라드','우워어어어어');
```
##### 7. update
```
update songs set release_date = '2006-07-01', lyric='0330가사 수정' where id = 101;
```
##### 8. delete
```
delete from songs where id=101;
```
##### 9. 특정 문자가 포함된 것 가져오기 
```
#앨범의 ost songs 가져오기, name,singer, album,release_date,genre
select album from songs where album LIKE '% OST %';
select album from songs where album not like '% OST %';
```
##### limit
```
select * from songs limit 10;
```

