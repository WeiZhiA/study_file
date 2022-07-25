-- student: id, name, age, gander
-- course: id,name,t_id
-- scores: s_id, score, c_id
-- teacher: id, name

-- 第一题 查询‘01’号学生的姓名和各科成绩。
select st.name “学生姓名”, co.name “科目”, sc.score “成绩” from student st
right join score sc on sc.s_id = st.id 
left join course co on co.id = sc.c_id where st.id = '01';


-- 第二题 查询各个学科的平均成绩，最高成绩。
-- 好的
select co.name, max(sc.score), avg(sc.score) from score
left join course co on co.id = sc.c_id group by sc.c_id;

-- 不好的
select c.name, t.avg, t.max_score from course c left join 
(select s.c_id cid, Avg(s.score) avg_score, max(s.score) max_score from score) max_score from score s group s.c_id) t

-- 第三题 查询每个同学的最高成绩及科目名称
select maxSc.name, maxSc.score, co.name from
(select sc.s_id sid, sc.name name, Max(sc.score) score from scores sc 
left join student st on st.id = sc.s_id group by st.id, st.name) maxSc
left join scores sc on sc.s_id = maxSc.sid and sc.score = maxSc.score
left join course co on co.id = maxSc.cid;


-- 第五题 查询每个课程最高分的同学信息
select * from 
(select co.id c_id, co.name c_name, Max(sc.score) score from scores sc
left join course co on co.id = sc.c_id group by co.id and co.name) maxSc
left join scores sc on sc.c_id = maxSc.c_id and maxSc.score = sc.score
left join student st on st.id = sc.s_id


-- 7 查询平均成绩及格的同学的信息
select st.id, st.name, Avg(sc.score) from score sc
left join student st on st.id = sc.s_id
group by st.id, st.name
Having Avg(sc.score) > 60;


-- 8 将学生按照总分数进行排名。

select st.id, st.name, Sum(sc.score) “总成绩” from score sc
left join student st on st.id = sc.s_id
group by st.id, st.name
order by Sum(sc.score) DESC


-- 11, 如果是group by，想展示的必须全部放到group by条件中
select te.id, te.name, co.course, Max(so.score) from teacher te
right join course co on co.t_id = te.id
left join scores so on so.c_id = co.id
group by te.id, te.name, co.course;


-- 17 查询有不及格课程的同学信息。 
select * from student st 
where st.id in (select s_id from score sc where sc.score < 60 group by sc.s_id)

-- 18 求每门课程的学生人数。 
select co.id, co.name, Count(*) from scores sc
left join course co on sc.c_id = co.id
group by co.id, co.name

-- 20 查询平均成绩大于等于60分的同学的学生编号和学生姓名和平均成绩。
select * from student st left join scores sc on sc.s_id = st.id
group by st.id, st.name Having Count(sc.score) = 1


-- 29 查询课程名称为”java”，且分数低于60的学生姓名和分数。
select st.id, st.name from scores sc left join student st on sc.id = st.id
where sc.t_id in (select te.id from teacher te where te.name = "张楠")