[ToC]

# Systemctl、Service、chkconfig

## 1. systemctl

> systemctl是RHEL 7 的服务管理工具中主要的工具，它融合之前service和chkconfig的功能于一体。可以使用它永久性或只在当前会话中启用/禁用服务。所以systemctl命令是service命令和chkconfig命令的集合和代替。
> Systemctl是一个systemd工具，主要负责控制systemd系统和服务管理器。
> Systemd是一个系统管理守护进程、工具和库的集合，用于取代System V初始进程。Systemd的功能是用于集中管理和配置类UNIX系统。
> systemd即为system daemon,是linux下的一种init软件。

### 1.1 systemctl 命令常见用法

1. systemctl [system control]
    | 命令                      | 说明                    |
    | --------------------------| -----------------------|
    | systemctl list-unit-files | 列出所有可用单元 |
    | systemctl list-unit-files --type=service| 列出所有服务 |
    | systemctl list-unit-files --type| 列出系统的各项服务，挂载，设备 |
    | systemctl list-unit | 列出所有可用单元 |
    | systemctl --failed | 列出所有失败单元 |
    | systemctl is-enabled httpd.service | 检查某个单元是否启动 |
    | systemctl status httpd.service | 检查某个服务的运行状态 |
    | systemctl restart httpd.service   |  重启某个服务  |
    | systemctl stop httpd.service      |   停止某个服务 |
    | systemctl start httpd.service     |    启动某个服务|
    | systemctl is-active httpd         |  查询某个服务是否激活 |
    | systemctl disable httpd           |  禁用开机启动某个服务 |
    | systemctl enable httpd            | 启用开机启动某个服务 |
    | systemctl kill httpd              | 杀死某个服务 |
    | systemctl get-default             | 获得系统默认启动级别 |
    | systemctl set-default multi-user.target | 设置默认启动级别 |
    | systemctl isolate multiuser.target | 启动运行等级 |

### 1.2 Ubuntu SystemCtl Help

sudo systemctl  --help

Query or send control commands to the system manager.

Unit Commands:
  list-units [PATTERN...]             List units currently in memory
  list-sockets [PATTERN...]           List socket units currently in memory,
                                      ordered by address
  list-timers [PATTERN...]            List timer units currently in memory,
                                      ordered by next elapse
  start UNIT...                       Start (activate) one or more units
  stop UNIT...                        Stop (deactivate) one or more units
  reload UNIT...                      Reload one or more units
  restart UNIT...                     Start or restart one or more units
  try-restart UNIT...                 Restart one or more units if active
  reload-or-restart UNIT...           Reload one or more units if possible,
                                      otherwise start or restart
  try-reload-or-restart UNIT...       If active, reload one or more units,
                                      if supported, otherwise restart
  isolate UNIT                        Start one unit and stop all others
  kill UNIT...                        Send signal to processes of a unit
  clean UNIT...                       Clean runtime, cache, state, logs or
                                      configuration of unit
  is-active PATTERN...                Check whether units are active
  is-failed PATTERN...                Check whether units are failed
  status [PATTERN...|PID...]          Show runtime status of one or more units
  show [PATTERN...|JOB...]            Show properties of one or more
  stop UNIT...                        Stop (deactivate) one or more units
  reload UNIT...                      Reload one or more units
  restart UNIT...                     Start or restart one or more units
  try-restart UNIT...                 Restart one or more units if active
  reload-or-restart UNIT...           Reload one or more units if possible,
                                      otherwise start or restart
  try-reload-or-restart UNIT...       If active, reload one or more units,
                                      if supported, otherwise restart
  isolate UNIT                        Start one unit and stop all others
  kill UNIT...                        Send signal to processes of a unit
  clean UNIT...                       Clean runtime, cache, state, logs or
                                      configuration of unit
  is-active PATTERN...                Check whether units are active
  is-failed PATTERN...                Check whether units are failed
  status [PATTERN...|PID...]          Show runtime status of one or more units
  show [PATTERN...|JOB...]            Show properties of one or more
                                      units/jobs or the manager
  cat PATTERN...                      Show files and drop-ins of specified units
  set-property UNIT PROPERTY=VALUE... Sets one or more properties of a unit
  help PATTERN...|PID...              Show manual for one or more units
  reset-failed [PATTERN...]           Reset failed state for all, one, or more
                                      units
  list-dependencies [UNIT...]         Recursively show units which are required
                                      or wanted by the units or by which those
                                      units are required or wanted
Unit File Commands:
  list-unit-files [PATTERN...]        List installed unit files
  enable [UNIT...|PATH...]            Enable one or more unit files
  disable UNIT...                     Disable one or more unit files
  reenable UNIT...                    Reenable one or more unit files
  preset UNIT...                      Enable/disable one or more unit files
                                      based on preset configuration
  preset-all                          Enable/disable all unit files based on
                                      preset configuration
  is-enabled UNIT...                  Check whether unit files are enabled
  mask UNIT...                        Mask one or more units
  unmask UNIT...                      Unmask one or more units
  link PATH...                        Link one or more units files into
                                      the search path
  revert UNIT...                      Revert one or more unit files to vendor
                                      version
  add-wants TARGET UNIT...            Add 'Wants' dependency for the target
                                      on specified one or more units
  add-requires TARGET UNIT...         Add 'Requires' dependency for the target
                                      on specified one or more units
  edit UNIT...                        Edit one or more unit files
  get-default                         Get the name of the default target
  set-default TARGET                  Set the default target

Machine Commands:
  list-machines [PATTERN...]          List local containers and host

Job Commands:
  list-jobs [PATTERN...]              List jobs
  cancel [JOB...]                     Cancel all, one, or more jobs

Environment Commands:
  show-environment                    Dump environment
  set-environment VARIABLE=VALUE...   Set one or more environment variables
  unset-environment VARIABLE...       Unset one or more environment variables
  import-environment [VARIABLE...]    Import all or some environment variables

Manager State Commands:
  daemon-reload                       Reload systemd manager configuration
  daemon-reexec                       Reexecute systemd manager
  log-level [LEVEL]                   Get/set logging threshold for manager
  log-target [TARGET]                 Get/set logging target for manager
  service-watchdogs [BOOL]            Get/set service watchdog state

System Commands:
  is-system-running                   Check whether system is fully running
  default                             Enter system default mode
  rescue                              Enter system rescue mode
  emergency                           Enter system emergency mode
  halt                                Shut down and halt the system
  poweroff                            Shut down and power-off the system
  reboot [ARG]                        Shut down and reboot the system
  kexec                               Shut down and reboot the system with kexec
  exit [EXIT_CODE]                    Request user instance or container exit
  switch-root ROOT [INIT]             Change to a different root file system
  suspend                             Suspend the system
  hibernate                           Hibernate the system
  hybrid-sleep                        Hibernate and suspend the system
  suspend-then-hibernate              Suspend the system, wake after a period of
                                      time, and hibernate
Options:
  -h --help              Show this help
     --version           Show package version
     --system            Connect to system manager
     --user              Connect to user service manager
  -H --host=[USER@]HOST  Operate on remote host
  -M --machine=CONTAINER Operate on a local container
  -t --type=TYPE         List units of a particular type
     --state=STATE       List units with particular LOAD or SUB or ACTIVE state
     --failed            Shorcut for --state=failed
  -p --property=NAME     Show only properties by this name
  -a --all               Show all properties/all units currently in memory,
                         including dead/empty ones. To list all units installed
                         on the system, use 'list-unit-files' instead.
  -l --full              Don't ellipsize unit names on output
  -r --recursive         Show unit list of host and local containers
     --reverse           Show reverse dependencies with 'list-dependencies'
     --with-dependencies Show unit dependencies with 'status', 'cat',
                         'list-units', and 'list-unit-files'.
     --job-mode=MODE     Specify how to deal with already queued jobs, when
                         queueing a new job
  -T --show-transaction  When enqueuing a unit job, show full transaction
     --show-types        When showing sockets, explicitly show their type
     --value             When showing properties, only print the value
  -i --ignore-inhibitors When shutting down or sleeping, ignore inhibitors
     --kill-who=WHO      Whom to send signal to
  -s --signal=SIGNAL     Which signal to send
     --what=RESOURCES    Which types of resources to remove
     --now               Start or stop unit after enabling or disabling it
     --dry-run           Only print what would be done
                         Currently supported by verbs: halt, poweroff, reboot,
                             kexec, suspend, hibernate, suspend-then-hibernate,
                             hybrid-sleep, default, rescue, emergency, and exit.
  -q --quiet             Suppress output
     --wait              For (re)start, wait until service stopped again
                         For is-system-running, wait until startup is completed
     --no-block          Do not wait until operation finished
     --no-wall           Don't send wall message before halt/power-off/reboot
     --no-reload         Don't reload daemon after en-/dis-abling unit files
     --no-legend         Do not print a legend (column headers and hints)
     --no-pager          Do not pipe output into a pager
     --no-ask-password   Do not ask for system passwords
     --global            Enable/disable/mask unit files globally
     --runtime           Enable/disable/mask unit files temporarily until next
                         reboot
  -f --force             When enabling unit files, override existing symlinks
                         When shutting down, execute action immediately
     --preset-mode=      Apply only enable, only disable, or all presets
     --root=PATH         Enable/disable/mask unit files in the specified root
                         directory
  -n --lines=INTEGER     Number of journal entries to show
  -o --output=STRING     Change journal output mode (short, short-precise,
                             short-iso, short-iso-precise, short-full,
                             short-monotonic, short-unix,
                             verbose, export, json, json-pretty, json-sse, cat)
     --firmware-setup    Tell the firmware to show the setup menu on next boot
     --boot-loader-menu=TIME
                         Boot into boot loader menu on next boot
     --boot-loader-entry=NAME
                         Boot into a specific boot loader entry on next boot
     --plain             Print unit dependencies as a list instead of a tree

## 2. service

> service命令可以启动、停止、重新启动和关闭系统服务，还可以显示所有系统服务的当前状态。
> service命令的作用是去/etc/init.d目录下寻找相应的服务，进行开启和关闭等操作。

### 2.1 service 常见命令

    | 命令                     | 说明                    |
    | -------------------------| -----------------------|
    | service httpd start/stop | 开启关闭一个服务        |
    | service --status-all     | 查看系统服务的状态      |

## 3. chkconfig

> 是管理系统服务(service)的命令行工具。所谓系统服务(service)，就是随系统启动而启动，随系统关闭而关闭的程序。
> chkconfig可以更新(启动或停止)和查询系统服务(service)运行级信息。更简单一点，chkconfig是一个用于维护/etc/rc[0-6].d目录的命令行工具。

### 3.1 chkconfig 常见命令

    | 命令                     | 说明                    |
    | -------------------------| -----------------------|
    | chkconfig [--list] [--type <类型>] [名称] |         |
    | chkconfig --add <名称>    |       |
    | chkconfig --del <名称>    |               |
    | chkconfig --override <名称> |            |
    | chkconfig [--level <级别>] [--type <类型>] <名称> <on|off|reset|resetpriorities> |             |
    | chkconfig name on/off/reset | 设置service开机是否启动    |      
