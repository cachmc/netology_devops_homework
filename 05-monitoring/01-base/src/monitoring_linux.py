import json
import calendar
from datetime import datetime
from datetime import timezone
import re

path_cpustat = "/proc/stat"
path_meminfo = "/proc/meminfo"
path_uptime = "/proc/uptime"
path_metrics_log = "/var/log"

timestamp = calendar.timegm(datetime.now(timezone.utc).utctimetuple())
metrics_json = {"timestamp": timestamp}
cpustat_array = []
meminfo_dict = {}

### Parse CPU
file = open(path_cpustat)
cpustat = file.readlines()
file.close()

for line in cpustat:
    line = line.replace("\n", "")
    line = re.sub(r'\s+', ' ', line)
    parse_cpustat = line.split(" ")
    if "cpu" in parse_cpustat[0]:
        proc_sum_operation = 0
        for n in parse_cpustat[1:]:
            proc_sum_operation += int(n)
        cpustat_array.append(
            {
                "name": parse_cpustat[0],
                "used_perc": int((proc_sum_operation - int(parse_cpustat[4])) / proc_sum_operation * 100),
                "user_s": int(parse_cpustat[1]),
                "system_s": int(parse_cpustat[3]),
                "iowait_s": int(parse_cpustat[5])
            }
        )
metrics_json['cpu'] = cpustat_array

### Parse RAM
file = open(path_meminfo)
meminfo = file.readlines()
file.close()

for line in meminfo:
    line = line.replace("\n", "").replace(" ", "")
    parse_line = line.split(":")
    if len(parse_line) > 0:
        if len(parse_line) == 2:
            meminfo_dict[parse_line[0]] = parse_line[1]
        else:
            meminfo_dict[parse_line[0]] = 0

if "kB" in meminfo_dict['MemTotal']:
    metrics_json['ram_total_b'] = int(meminfo_dict['MemTotal'].replace("kB", "")) * 1024
if "kB" in meminfo_dict['MemFree']:
    metrics_json['ram_free_b'] = int(meminfo_dict['MemFree'].replace("kB", "")) * 1024

### Parse Uptime
file = open(path_uptime)
uptime = file.readlines()
file.close()

if len(uptime) > 0:
   parse_uptime = uptime[0].split(" ")
   metrics_json['uptime_s'] = int(float(parse_uptime[0]))

### Write to file
formatted_date = datetime.today().strftime("%y-%m-%d")
with open(path_metrics_log+"/"+formatted_date+"-awesome-monitoring.log", 'a') as file:
    file.write(json.dumps(metrics_json) + '\n')
