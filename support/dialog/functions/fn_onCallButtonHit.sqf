
if (
isNil "supportType" ||
{isNil "supp_param1"} ||
{isNil "supp_param2"} ||
{supp_param4 isEqualTo []} ||
{(supportType == "Artillery" && {isNil "supp_param3"})}
) exitWith {hint "nil param occur"; sleep 1; hint "";};

supp_array = true;
closeDialog 0;

