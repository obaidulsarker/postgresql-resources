-- Step-1: Install python packages in PostgreSQL linux server
sudo yum install -y postgresql-plpython3
sudo pip3 install requests

-- Step2: Create plpython extention and language in psql.
psql> CREATE EXTENSION plpython3u;
psql> CREATE LANGUAGE plpython3u;


-- Step3: Now we will create TABLE, FUNCTION, TRIGGER FUNCTION and TRIGGER. 
-- We will create a function using Python which will be executed through trigger. The function will call a API.
 
-- DROP TABLE IF EXISTS public.management_sipaccount;

CREATE TABLE IF NOT EXISTS public.management_sipaccount
(
    sipaccount_id integer NOT NULL DEFAULT nextval('management_sipaccount_sipaccount_id_seq'::regclass),
    voicemail_password character varying(500) COLLATE pg_catalog."default" NOT NULL,
    description text COLLATE pg_catalog."default",
    CONSTRAINT management_sipaccount_pkey PRIMARY KEY (sipaccount_id)
)

TABLESPACE pg_default;

-- FUNCTION: public.execute_api(integer)

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
    api_url = 'https://portal.carismahostip.com/api/users/update_sipaccount'
    headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Token 3469bc9092c887da28b9704c79db0375e7168d8d'
    }
    data = {
        'sipaccount_id': f'{sipaccount_id}',
        'description': 'vm_password changed'
    }

    response = requests.post(api_url, headers=headers, json=data)
    data2 = f'sipaccount_id={sipaccount_id}'
    file_path = r"/var/lib/edb/as15/scripts/example.txt"
    with open(file_path, 'w') as file:
        file.write(data2)

#args = sys.argv
#sipaccount_id_parm=param1 = args[1]
	
execute_api(sipaccount_id)
	
$BODY$;


CREATE OR REPLACE FUNCTION public.update_description()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
BEGIN

	DECLARE
        api_response TEXT;
	BEGIN
		PERFORM execute_api(NEW.sipaccount_id);
		api_response = 'password changed';
        -- Assuming the API response contains the updated value for the column
        -- Update the column with the API response
        UPDATE management_sipaccount SET description = api_response 
			WHERE sipaccount_id = NEW.sipaccount_id;
        
        RETURN NEW;
    END;
END;
$BODY$;

-- Trigger: vm_password_change

-- DROP TRIGGER IF EXISTS vm_password_change ON public.management_sipaccount;

CREATE OR REPLACE TRIGGER vm_password_change
    AFTER UPDATE OF voicemail_password
    ON public.management_sipaccount
    FOR EACH ROW
    EXECUTE FUNCTION public.update_description();
