# SQL规范之MySQL

## 整体设计规范

+ Stored Procedure、Function、Trigger不成熟，不建议使用
+ UUID()、User() 导致主备数据不一致，不要使用
+ 不用外键
+ 自动重连机制的长连接，回收没有使用的长连接
+ UTF-8编码



## 命名

+ 命名全部采用小写，并且名称前后不能加引号。

   | 对象           | 规则                                                         |
   | -------------- | ------------------------------------------------------------ |
   | 表             | 同一个模块的表尽可能使用相同的前缀，表名尽可能表达含义如： CRM_SAL_FUND_ITEM。 |
   | 字段           | 尽可能使用表达实际含义的英文单词或缩写，如，公司ID，不要使用：corporation_id, 而用：corp_id 即可。 |
   | 布尔值类型字段 | 命名为is+描述。如member表上表示是否为enabled的会员的字段命名为IsEnabled。 |
   | 索引           | <table_name>_<column_name>_ind,各部分以下划线（_）分割。多单词组成的column name，取前几个单词首字母，加末单词组成column_name。如：sample表member_id上的索引：sample_mid_ind。 |
   | 主键约束       | _pk结尾，<table_name>_pk；                                   |
   | unique约束     | _uk结尾，<table_name>_<column_name>_uk；                     |
   | check约束      | _ck 结尾，<table_name>_<column_name>_ck；                    |
   | 外键约束       | _fk 结尾，以pri连接本表与主表，<table_name>_pri_<table_name>_fk； |
   | 触发器         | <table_name>_A(After)B(Before)I(Insert)U(Update)D(Delete)_trg。 若是用于同步的触发器以sync作为前缀：sync_<table_name>_trg。 |
   | 过程           | 以proc_开头                                                  |
   | 函数           | 以func_开头                                                  |
   | 本地变量       | 以v_为前缀                                                   |
   | 参数           | 以p_为前缀，可以带_I(输入)，_O(输出)、_IO(输入输出）表示参数的输入输出类型。 |

  

## 对象设计规范

+ 当字段的类型为枚举型或布尔型时，建议使用char(1)类型。

+ 同一表中，所有varchar字段的长度加起来，不能大于65535.如果有这样的需求，请使用TEXT/LONGTEXT类型。

+ 获取当前时间请用now()，尽量避免使用 sysdate()

+ 字段类型

  | 类型        | 规范                                                         |
  | ----------- | ------------------------------------------------------------ |
  | NUMBER(p,s) | 固定精度数字类型                                             |
  | NUMBER      | 不固定精度数字类型，当不确定数字的精度时使用，PK通常使用此类型 |
  | DATE        | 当仅需精确到秒时，选择DATE而不是TIMESTAMP类型                |
  | TIMESTAMP   | 扩展日期类型，不建议使用                                     |
  | VARCHAR2    | 变长字符串，最长4000个字节                                   |
  | CHAR        | 定长字符串，除非是CHAR(1),否则不要使用                       |
  | CLOB        | 当超过4000字节时使用，但是要求这个字段必须单独创建到一张表中，然后有PK与主表关联。此类型应该尽量控制使用 |

+ 字段注释

  | 标签名   | 中文含义                       | 必填 | 备注                                                 |
  | -------- | ------------------------------ | ---- | ---------------------------------------------------- |
  | @desc    | 字段中文描述                   | Yes  |                                                      |
  | @fk      | 字段对应的外键字段             |      |                                                      |
  | @values  | 取值范围说明。多个值以"\|"分隔 |      |                                                      |
  | @sample  | 数据范本                       |      | 对于复杂数据格式，最好给一个数据范本。               |
  | @formula | 计算公式                       |      | 写明该字段由哪些字段以何种公式计算得到。             |
  | @logic   | 数据逻辑                       |      | 简要写明该字段的数据是在何种业务规则下，如何变化的。 |
  | @redu    | 标识此字段冗余                 |      |                                                      |
  | @depr    | 标识此字段已废弃               |      | 简要写明：废弃人 废弃日期 废弃原因                   |

+ 索引

  + 不要创建带约束的索引，所有的约束效果都通过显示创建约束然后再using index一个已经创建好的普通索引来实现。

+ 约束

  + 主键最好是无意义的，，统一由Auto-Increment字段生成整型数据，不建议使用组合主键。
  + 若要达到唯一性限制的效果，不要创建unique index，必须显式创建普通索引和约束（pk或uk），即先创建一个以约束名命名的普通索引，然后创建一个约束，用using index ...指定索引。
  + 当删除约束的时候，为了确保不影响到index，最好加上keep index参数。
  + 当万不得已必须使用外健的话，必须在外健列创建INDEX。

+ 避免多余的排序。使用GROUP BY 时，默认会进行排序，当你不需要排序时，可以使用order by null

  `Select product,count(*) cnt from crm_sale_detail group by product order by null;`

+ 全模糊查询无法使用INDEX，应当尽可能避免

  `select * from table where name like '%jacky%';`

+ 多表 Join 的分页语句，如果过滤条件在单个表上，需要先分页，再 Join：

+ "join"、"in"、"not in"、"exsits"和"not exists"的使用

  + 比较IN,EXISTS,JOIN
    + 按效率从好到差排序: 
    + 字段上有索引: EXISTS, IN, JOIN 
    + 字段上没有索引: JOIN, EXISTS ,IN
  + Anti-Joins: NOT IN ,NOT EXISTS, LEFT JOIN
    + 按效率从好到差排序: 
    + 字段上有索引: LEFT JOIN, NOT EXISTS, NOT IN 
    + 字段上没有索引: NOT IN, NOT EXISTS, LEFT JOIN

+ 对大表进行查询时，在SQLMAP中需要加上对空条件的判断语句

  ```
  select count from iw_user usr 
  <dynamic prepend="where"> 
      <isNotEmpty prepend="AND" property="userId"> 
      	usr.iw_user_id = #userId:varchar# 
      </isNotEmpty> 
      <isNotEmpty prepend="AND" property="email"> 
      	usr.email = #email:varchar# 
      </isNotEmpty> 
      <isNotEmpty prepend="AND" property="certType"> 
      	usr.cert_type = #certType:varchar# 
      </isNotEmpty> 
      <isNotEmpty prepend="AND" property="certNo"> 
      	usr.cert_no = #certNo:varchar# 
      </isNotEmpty> 
      <isEmpty property="userId"> 
          <isEmpty property="email"> 
              <isEmpty property="certNo"> 
              	query not allowed 
              </isEmpty> 
          </isEmpty> 
      </isEmpty> 
  </dynamic>
  ```

+ 聚合函数常见问题
  + 不要使用count(1)代替count（*） 
  + count(column_name)计算该列不为NULL的记录条数
  + count(distinct column_name)计算该列不为NULL的不重复值数量
  + count()函数不会返回NULL，但sum()函数可能返回NULL，可以使用ifnull(sum(qty),0)来避免返回NULL

+ NULL的使用

  + 理解NULL的含义，是"不确定"，而不是"空" 
  + 查询时，使用is null或者is not null
  + 更新时，使用等于号，如：update tablename set column_name = null