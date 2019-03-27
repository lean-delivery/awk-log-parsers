function convert_time(dt)
{ # converts date & time from typical text representation like '2017-05-15 12:43:32,243' to standard ISO8601 format '2017-05-15T12:43:32.243Z'
    split(dt,dat,/-|\/|:|,|\.| /) # splitting text timestamp to separate numeric values by separators: '-', '/', ':', ',' '.' or space
    if (!dat[7])		# if microseconds are absent set related variable to '000'
        dat[7]="000"
    ret =  mktime(dat[1]" "dat[2]" "dat[3]" "dat[4]" "dat[5]" "dat[6]) 	# calculate unix epoch time based on source text timestamp value
    if (ret != -1)	# check if timestamp was processed successfully
    	ret = strftime("%Y-%m-%dT%H:%M:%S", ret ,1)"."dat[7]"Z"		# converting unix epoch time to ISO8601 format using UTC time zone
    return ret		# output resulting ISO8601 text timestamp
}			# if input data was incorrect and conversion failes output will be -1
