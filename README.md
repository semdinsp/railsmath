# railsmath
Ruby on Rails mathematica integration  post and get activerecord models from mathematica to a ruby on rails project
## Test File
This is included.  See rails test.mt for working examples but they will need to be changed to point to your rails application and model names
Updated on Oct 21 2016 to support Mathematic version 11 UrlExecute function.  This code should now run transparently on both 11 and 10 systems.

##  Code Philiosphy
Name the active record model and then post the data a a set of rules.  For example if your activerecord model is books and each book has a name and author you would post a book wiwith the name and author as a set of rules.  This is sent to Ruby on Rails code as a json post.

## Mathematica integration
Sample code is as follows

    Needs["rails`"];
    host = "http://127.0.0.1:5522/"; 
    res = rails`railsGetActiveRecordModel["net_asset_value", 1, host ];
    res["accountname"]

So in this model the model name is net_assetvalue and we getting record 1.  THere are methods to get all the records and to post record.  You can see the code in the test template

### Mathematica integration with authenticationn
I have added HTTP Basic authentication support to the code by appending an association compposed of username and password.  This currently only supports HTTP basic authentication and is passed a HTML header setting Authorization set to a base 64 combination of username:password.  THis seems to consistently work.  If you add the auth association to the call you get authorization and if it is missing or empty then there is no authorization. 

    Needs["rails`"];
    host = "http://127.0.0.1:5522/";
    auth=<|"username"-> "testuser","password"->"testpass"|>; 
    res = rails`railsGetActiveRecordModel["net_asset_value", 1, host,auth ];
    res["accountname"]

## Logging
Now has a basic logging facility.  
Open log with file name and directory
then use railsLog to log it.  Maybe in the future I will add priority and file rotation but right now this is all i need.  It sets a global variable called railsLogStream to use for output.  The default directory is "~/dreamLog" but it can be changed.  It will zip old files automatically and rename them

Logging opens a file stream that you can write to.  Sample code is as follows:
    
    Needs["rails`"];
    railsLogOpen["valueScreens"];  (* need to open rails logging *)
    lmsg = StringJoin["Count members: ", ToString[Length[members]]];
    rails`railsLog[rails`railsLogStream, lmsg, {rails`railsSystemStatus[]}];
    railsLogClose[rails`railsLogStream];  
