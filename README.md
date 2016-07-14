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
