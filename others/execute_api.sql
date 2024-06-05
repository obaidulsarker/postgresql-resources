
-- DROP FUNCTION IF EXISTS public.execute_api(integer);

CREATE OR REPLACE FUNCTION public.execute_api(
	sipaccount_id integer)
    RETURNS void
    LANGUAGE 'plpython3u'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
import requests

def execute_api(sipaccount_id):
    api_url = 'https://portal.carismahostip.com/api/users/update_apply_directory_api'
    headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Token 3469bc9092c887da28b9704c79db0375e7168d8d'
    }
    

    response = requests.post(api_url, headers=headers)
    data2 = f'sipaccount_id={sipaccount_id}'

#args = sys.argv
#sipaccount_id_parm=param1 = args[1]
	
execute_api(sipaccount_id)
	
$BODY$;
