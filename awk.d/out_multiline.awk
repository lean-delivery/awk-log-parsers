function out_multiline(sourcelog)
{
    fields_name = logtype[sourcelog] "_fields"
    field_name = logtype[sourcelog] "_field"
    @fields_name(sourcelog)
    fflush()
}