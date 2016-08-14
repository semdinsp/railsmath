# railsmath
Rails mathematica integration  post and get activerecord models from mathematica to a ruby on rails project
## Test File
This is included.  See rails test.mt for working examples but they will need to be changed to point to your rails application and model names

## Mathematica integration
Sample code is as follows

    Needs["rails`"];
    host = "http://127.0.0.1:5522/"; 
    res = rails`railsGetActiveRecordModel["net_asset_value", 1, host ];
    res["accountname"]

## Logging
Now has a basic logging facility.  
Open log with file name and directory
then use railsLog to log it.  Maybe in the future I will add priority and file rotation but right now this is all i need.  It sets a global variable called railsLogStream to use for output
