function out_json(object,     i)
{
    arr = ""
    for (i in object) {
        if (isarray(object[i]))
            arr = arr "\"" i "\":" out_json(object[i],      j) ","
        else
            arr = arr "\"" i "\":\"" object[i] "\","
    }
    arr = substr(arr,1,length(arr)-1)
    return "{" arr "}"
}