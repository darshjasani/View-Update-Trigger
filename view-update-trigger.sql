create table vtemp(seatno number(10), vdate date, action varchar2(20));
create view v1 as 
select a.seatno1,a.name1,b.average from student1 a, result b where a.seatno1 = b.seatno;
create or replace trigger hey  instead of insert on v1 for each row
begin
 insert into student1(seatno1,name1) values(:new.seatno1,:new.name1);
 insert into result(average) values(:new.average);
 insert into vtemp values(:new.seatno1,sysdate,'Insert');
end;
/
insert into v1 values(111,'kane',89);
create or replace trigger t32
instead of delete
on v1
for each row
begin
 delete from student1 where seatno1 = :old.seatno1 and name1 = :old.name1;
 delete from result where average = :old.average;
 insert into vtemp values(:old.seatno1,sysdate,'Delete');
end;
/
create or replace trigger hey1 instead of update on v1 for each row
begin
 update student1 set seatno1 = :new.seatno1, name1 = :new.name1
 where seatno1 = :old.seatno1;
 update result set seatno = :new.seatno1 , average = :new.average
 where average = :old.average;
 insert into vtemp values(:new.seatno1,sysdate,'Update');
end;
/
