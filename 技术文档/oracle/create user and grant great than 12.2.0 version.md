在 Oracle 12c 12.2.0.1 版本中创建PDB 用户并且登录

1. sqlplus / as sysdba
2. show pdbs;
3. alter sesson set container = pdb_name;
4. startup
5. create user pdb_user_name identified by pdb_user_pwd;
6. grant connect,resource to pdb_user;
7. 

查看数据库监听状态

1. 数据库监听状态
   lsnrctl status
2. 连接到数据库 conn db_conn_name/db_conn_pwd
3. sqlplus db_conn_name/password@IP:PORT/PDB_NAME
4.
