

-- Select rows from a Table or View '' in schema 'dbo'
SELECT st.StudentNo,st.Name,st.Email,sc.ExamScore,sc.ExamDate
FROM dbo.student st CROSS APPLY
(
    select top 2 * from dbo.score sc where sc.StudentNo = st.StudentNo ORDER BY sc.ExamDate desc
)  
sc

SELECT st.StudentNo,st.Name,st.Email,sc.ExamScore,sc.ExamDate
FROM dbo.student st OUTER APPLY
(
    select top 2 * from dbo.score sc where sc.StudentNo = st.StudentNo ORDER BY sc.ExamDate desc
)  
sc


-- 学生、成绩、科目

-- 1. 查询所有的语文成绩第一名
SELECT top 1 st.StudentNo,st.Name,sc.SubjectId,sc.ExamScore,sc.ExamDate
FROM dbo.student st CROSS APPLY
(
    select  * from dbo.score sc where sc.StudentNo = st.StudentNo and sc.SubjectId = 1
)  
sc ORDER BY sc.ExamScore DESC;



-- 1. 查询语文成绩第一名
select top 1 st.StudentNo,st.Name,sc.SubjectId,sc.ExamScore,sc.ExamDate
from score sc join student st on sc.StudentNo = sc.StudentNo and sc.SubjectId = 1
order by sc.ExamScore desc;
------ or
SELECT st.StudentNo,st.Name,sc.SubjectId,sc.ExamScore,sc.ExamDate from (
    select top 1 sc.StudentNo,sc.SubjectId,sc.ExamScore,sc.ExamDate from score sc where sc.SubjectId = 1 ORDER BY sc.ExamScore DESC
) sc join student st on st.StudentNo = sc.StudentNo;

-- 2. 查询各科成绩第一名
SELECT sb.SubjectName,t.ExamScore,st.Name
from dbo.subject sb OUTER APPLY
(SELECT MAX(ExamScore) ExamScore,MAX(StudentNo) StudentNo  FROM dbo.score 
where score.SubjectId = sb.subjectid GROUP by SubjectId) t
left join student st on st.StudentNo = t.StudentNo

-- 3. 查询每个人的各科考试成绩

SELECT st.Name,st.StudentNo,sb.subjectname,sc.ExamScore,sc.ExamDate from 
student st outer APPLY subject sb
left join score sc on sc.SubjectId = sb.subjectid and sc.StudentNo = st.StudentNo
ORDER BY st.StudentNo,sb.subjectid asc
;

-- 4. 行转列
SELECT st.Name,st.StudentNo,sb.subjectname,sc.ExamScore,sc.ExamDate from 
student st outer APPLY subject sb
left join score sc on sc.SubjectId = sb.subjectid and sc.StudentNo = st.StudentNo
;