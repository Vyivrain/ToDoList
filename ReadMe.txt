1) SELECT DISTINCT Status FROM Tasks ORDER BY Status ASC
2) SELECT Projects.ID, Tasks.Project_id, count(Tasks.Project_id) as NumTasks FROM Projects JOIN Tasks WHERE Projects.ID = Tasks.Project_id AND Projects.ID = 1
UNION
SELECT Projects.ID, Tasks.Project_id, count(Tasks.Project_id) as NumTasks FROM Projects JOIN Tasks WHERE Projects.ID = Tasks.Project_id AND Projects.ID = 2
UNION
SELECT Projects.ID, Tasks.Project_id, count(Tasks.Project_id) as NumTasks FROM Projects JOIN Tasks WHERE Projects.ID = Tasks.Project_id AND Projects.ID = 3
ORDER BY NumTasks DESC
3) SELECT Projects.ID, Projects.Name, Tasks.Project_id, count(Tasks.Project_id) as NumTasks FROM Projects JOIN Tasks WHERE Projects.ID = Tasks.Project_id AND Projects.ID = 1
UNION
SELECT Projects.ID, Projects.Name, Tasks.Project_id, count(Tasks.Project_id) as NumTasks FROM Projects JOIN Tasks WHERE Projects.ID = Tasks.Project_id AND Projects.ID = 2
UNION
SELECT Projects.ID, Projects.Name, Tasks.Project_id, count(Tasks.Project_id) as NumTasks FROM Projects JOIN Tasks WHERE Projects.ID = Tasks.Project_id AND Projects.ID = 3
ORDER BY Projects.Name 
4) SELECT * FROM Tasks WHERE Name LIKE 'N%'
5) SELECT Projects.name, count(Tasks.name) as NumberTasks FROM Projects JOIN Tasks ON Projects.ID = Tasks.Project_id WHERE ( Projects.Name LIKE '%a%' AND Projects.Name NOT LIKE 'a%' AND Projects.Name NOT LIKE '%a' ) 
6) SELECT Tasks.Name FROM Tasks
GROUP BY Tasks.Name
HAVING count(*) > 1
ORDER BY Tasks.Name
7) SELECT T1.ID, T1.Name, T1.Status, T1.Project_id, count(T1.Name) as TaskCount FROM Tasks T1, Tasks T2 WHERE T1.Name = T2.Name AND T1.Status = T2.Status AND T1.Project_id = 1 AND T1.ID != T2.ID ORDER BY TaskCount
8)  SELECT Projects.Name, count(case when Tasks.Status = 'completed' then 1 else NULL end ) as TaskCount 
FROM Projects 
INNER JOIN Tasks ON Projects.ID = Tasks.Project_id
GROUP BY Projects.Name
HAVING TaskCount > 10
ORDER BY Projects.ID