function check_file_closure(slog)               # checking input for file closure to avoid last string hanging in buffer
{
        if ($0~/Closing because close_inactive/) # if input file is closed, output last buffered line from this file and clear buffer
        {
                m = match($0, "File is inactive:")
                n = match($0, "Closing because close_inactive")
                closed_log = substr($0,m+18,n-m-20)
                gsub(/\\/,"\\\\",closed_log)
                if (closed_log in message)
                    out_multiline(closed_log)
                cleaner = logtype[closed_log] "_clean"
                @cleaner(closed_log)
        }
        next
}
