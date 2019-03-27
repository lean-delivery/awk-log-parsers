@load "json"
BEGIN{sourcelog="testlog.log"
logtype[sourcelog]="java"
index_name[sourcelog]="java"
}
{
     parsing_java(sourcelog)
}
 END{}
#=============================================================

function parsing_java(sourcelog)
{
clear_special_symbols()                                 # clear message from special characters to avoid JSON failures

parsing_result = match($0,/([0-9]{4}-[0-9]{2}-[0-9]{2}\s[0-9:,]+)\s+\[([^\[^\]]+\S)\s*\]\s+(WARN|INFO|ERROR|SEVERE|DEBUG|TRACE)\s+(.+)/,msg)
if (parsing_result == 0)
   parsing_result = match($0,/([0-9]{4}-[0-9]{2}-[0-9]{2}\s[0-9:,]+)\s+(WARN|INFO|ERROR|SEVERE|DEBUG|TRACE)\s+\[([^\[^\]]+\S)\s*\]\s+(.+)/,msg)
if (parsing_result > 0)
{
        tst = convert_time(msg[1])
        if (tst != -1)
        {
                if (sourcelog in message)
                  java_fields(sourcelog)
                timestamp[sourcelog] = tst
                source[sourcelog] = msg[2]
                severity[sourcelog] = msg[3]
                message[sourcelog] = msg[4]
                next
        }
}

if (sourcelog in message)
        message[sourcelog] = message[sourcelog] "\n" $0
}

function java_fields(sourcelog) # json multiline output
{
# list of keys and values of fields for JSON output
  logmsg["@timestamp"] = timestamp[sourcelog]
  logmsg["loglevel"] = severity[sourcelog]
  logmsg["source"] = source[sourcelog]
  logmsg["sourcelog"] = sourcelog
  logmsg["logtype"] = logtype[sourcelog]
  logmsg["message"] = message[sourcelog]
  logmsg["index"] = index_name[sourcelog]
  print json_toJSON(logmsg)
}

function java_clean(sourcelog)
{
    for (i in java_field)
        delete java_field[i]
    delete timestamp[sourcelog]
    delete severity[sourcelog]
    delete source[sourcelog]
    delete message[sourcelog]
    delete index_name[sourcelog]
    delete logtype[sourcelog]
}

@include "awk.d/out_multiline.awk"
@include "awk.d/convert_time.awk"
@include "awk.d/clear_special_symbols.awk"
