PGDMP  2                     |         	   fusionpbx    16.1 (Debian 16.1-1.pgdg110+1)    16.1 (Debian 16.1-1.pgdg110+1) �    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    16761 	   fusionpbx    DATABASE     u   CREATE DATABASE fusionpbx WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_CA.UTF-8';
    DROP DATABASE fusionpbx;
                postgres    false            �           0    0    DATABASE fusionpbx    ACL     .   GRANT ALL ON DATABASE fusionpbx TO fusionpbx;
                   postgres    false    4027                        2615    1090523    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
                postgres    false            �           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                   postgres    false    5            �           0    0    SCHEMA public    ACL     Q   REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;
                   postgres    false    5            M           1255    1090525    natural_sort(text)    FUNCTION       CREATE FUNCTION public.natural_sort(text) RETURNS bytea
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
	select string_agg(convert_to(coalesce(r[2], length(length(r[1])::text) || length(r[1])::text || r[1]), 'UTF8'),'\x00')
	from regexp_matches($1, '0*([0-9]+)|([^0-9]+)', 'g') r;
$_$;
 )   DROP FUNCTION public.natural_sort(text);
       public       	   fusionpbx    false    5            �            1259    1090526 
   fs_mapping    TABLE     �   CREATE TABLE public.fs_mapping (
    domain character varying(50) NOT NULL,
    extcount integer NOT NULL,
    first_fs character varying(50),
    second_fs character varying(50),
    id integer NOT NULL
);
    DROP TABLE public.fs_mapping;
       public         heap 	   fusionpbx    false    5            �            1259    1090529    fs_mapping_id_seq    SEQUENCE     �   CREATE SEQUENCE public.fs_mapping_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.fs_mapping_id_seq;
       public       	   fusionpbx    false    215    5            �           0    0    fs_mapping_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.fs_mapping_id_seq OWNED BY public.fs_mapping.id;
          public       	   fusionpbx    false    216            �            1259    1090530    v_access_control_nodes    TABLE     R  CREATE TABLE public.v_access_control_nodes (
    access_control_node_uuid uuid NOT NULL,
    access_control_uuid uuid,
    node_type text,
    node_cidr text,
    node_domain text,
    node_description text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
 *   DROP TABLE public.v_access_control_nodes;
       public         heap 	   fusionpbx    false    5            �            1259    1090535    v_access_controls    TABLE     5  CREATE TABLE public.v_access_controls (
    access_control_uuid uuid NOT NULL,
    access_control_name text,
    access_control_default text,
    access_control_description text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
 %   DROP TABLE public.v_access_controls;
       public         heap 	   fusionpbx    false    5            �            1259    1090540    v_applications    TABLE     <  CREATE TABLE public.v_applications (
    application_uuid uuid NOT NULL,
    application_name text,
    application_id uuid,
    application_category text,
    application_subcategory text,
    application_version numeric,
    application_license text,
    application_status text,
    user_uuid uuid,
    server_hostname text,
    application_updated timestamp with time zone,
    application_enabled text,
    application_description text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
 "   DROP TABLE public.v_applications;
       public         heap 	   fusionpbx    false    5            �            1259    1090545 	   v_bridges    TABLE     @  CREATE TABLE public.v_bridges (
    bridge_uuid uuid NOT NULL,
    domain_uuid uuid,
    bridge_name text,
    bridge_destination text,
    bridge_enabled text,
    bridge_description text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
    DROP TABLE public.v_bridges;
       public         heap 	   fusionpbx    false    5            �            1259    1090550    v_call_block    TABLE     1  CREATE TABLE public.v_call_block (
    domain_uuid uuid,
    call_block_uuid uuid NOT NULL,
    call_block_direction text,
    extension_uuid uuid,
    call_block_name text,
    call_block_country_code numeric,
    call_block_number text,
    call_block_count numeric,
    call_block_action text,
    call_block_app text,
    call_block_data text,
    date_added text,
    call_block_enabled text,
    call_block_description text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
     DROP TABLE public.v_call_block;
       public         heap 	   fusionpbx    false    5            �            1259    1090555    v_call_broadcasts    TABLE     �  CREATE TABLE public.v_call_broadcasts (
    call_broadcast_uuid uuid NOT NULL,
    domain_uuid uuid,
    broadcast_name text,
    broadcast_description text,
    broadcast_start_time numeric,
    broadcast_timeout numeric,
    broadcast_concurrent_limit numeric,
    recording_uuid uuid,
    broadcast_caller_id_name text,
    broadcast_caller_id_number text,
    broadcast_destination_type text,
    broadcast_phone_numbers text,
    broadcast_avmd text,
    broadcast_destination_data text,
    broadcast_accountcode text,
    broadcast_toll_allow text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
 %   DROP TABLE public.v_call_broadcasts;
       public         heap 	   fusionpbx    false    5            �            1259    1090560    v_call_center_agents    TABLE     �  CREATE TABLE public.v_call_center_agents (
    call_center_agent_uuid uuid NOT NULL,
    domain_uuid uuid,
    user_uuid uuid,
    agent_name text,
    agent_type text,
    agent_call_timeout numeric,
    agent_id text,
    agent_password text,
    agent_contact text,
    agent_status text,
    agent_logout text,
    agent_max_no_answer numeric,
    agent_wrap_up_time numeric,
    agent_reject_delay_time numeric,
    agent_busy_delay_time numeric,
    agent_no_answer_delay_time text,
    agent_record text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
 (   DROP TABLE public.v_call_center_agents;
       public         heap 	   fusionpbx    false    5            �            1259    1090565    v_call_center_queues    TABLE     �  CREATE TABLE public.v_call_center_queues (
    call_center_queue_uuid uuid NOT NULL,
    domain_uuid uuid,
    dialplan_uuid uuid,
    queue_name text,
    queue_extension text,
    queue_greeting text,
    queue_strategy text,
    queue_moh_sound text,
    queue_record_template text,
    queue_time_base_score text,
    queue_time_base_score_sec numeric,
    queue_max_wait_time numeric,
    queue_max_wait_time_with_no_agent numeric,
    queue_max_wait_time_with_no_agent_time_reached numeric,
    queue_tier_rules_apply text,
    queue_tier_rule_wait_second numeric,
    queue_tier_rule_no_agent_no_wait text,
    queue_timeout_action text,
    queue_discard_abandoned_after numeric,
    queue_abandoned_resume_allowed text,
    queue_tier_rule_wait_multiply_level text,
    queue_cid_prefix text,
    queue_outbound_caller_id_name text,
    queue_outbound_caller_id_number text,
    queue_announce_position text,
    queue_announce_sound text,
    queue_announce_frequency numeric,
    queue_cc_exit_keys text,
    queue_email_address text,
    queue_description text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
 (   DROP TABLE public.v_call_center_queues;
       public         heap 	   fusionpbx    false    5            �            1259    1090570    v_call_center_tiers    TABLE     �  CREATE TABLE public.v_call_center_tiers (
    call_center_tier_uuid uuid NOT NULL,
    domain_uuid uuid,
    call_center_queue_uuid uuid,
    call_center_agent_uuid uuid,
    agent_name text,
    queue_name text,
    tier_level numeric,
    tier_position numeric,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
 '   DROP TABLE public.v_call_center_tiers;
       public         heap 	   fusionpbx    false    5            �            1259    1090575    v_call_flows    TABLE     �  CREATE TABLE public.v_call_flows (
    domain_uuid uuid,
    call_flow_uuid uuid NOT NULL,
    dialplan_uuid uuid,
    call_flow_name text,
    call_flow_extension text,
    call_flow_feature_code text,
    call_flow_context text,
    call_flow_status text,
    call_flow_pin_number text,
    call_flow_label text,
    call_flow_sound text,
    call_flow_app text,
    call_flow_data text,
    call_flow_alternate_label text,
    call_flow_alternate_sound text,
    call_flow_alternate_app text,
    call_flow_alternate_data text,
    call_flow_enabled text,
    call_flow_description text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
     DROP TABLE public.v_call_flows;
       public         heap 	   fusionpbx    false    5            �            1259    1090580    v_conference_centers    TABLE     �  CREATE TABLE public.v_conference_centers (
    domain_uuid uuid,
    conference_center_uuid uuid NOT NULL,
    dialplan_uuid uuid,
    conference_center_name text,
    conference_center_extension text,
    conference_center_pin_length numeric,
    conference_center_greeting text,
    conference_center_description text,
    conference_center_enabled text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
 (   DROP TABLE public.v_conference_centers;
       public         heap 	   fusionpbx    false    5            �            1259    1090585    v_conference_control_details    TABLE     l  CREATE TABLE public.v_conference_control_details (
    conference_control_detail_uuid uuid NOT NULL,
    conference_control_uuid uuid,
    control_digits text,
    control_action text,
    control_data text,
    control_enabled text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
 0   DROP TABLE public.v_conference_control_details;
       public         heap 	   fusionpbx    false    5            �            1259    1090590    v_conference_controls    TABLE     (  CREATE TABLE public.v_conference_controls (
    conference_control_uuid uuid NOT NULL,
    control_name text,
    control_enabled text,
    control_description text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
 )   DROP TABLE public.v_conference_controls;
       public         heap 	   fusionpbx    false    5            �            1259    1090595    v_conference_profile_params    TABLE     �  CREATE TABLE public.v_conference_profile_params (
    conference_profile_param_uuid uuid NOT NULL,
    conference_profile_uuid uuid,
    profile_param_name text,
    profile_param_value text,
    profile_param_enabled text,
    profile_param_description text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
 /   DROP TABLE public.v_conference_profile_params;
       public         heap 	   fusionpbx    false    5            �            1259    1090600    v_conference_profiles    TABLE     (  CREATE TABLE public.v_conference_profiles (
    conference_profile_uuid uuid NOT NULL,
    profile_name text,
    profile_enabled text,
    profile_description text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
 )   DROP TABLE public.v_conference_profiles;
       public         heap 	   fusionpbx    false    5            �            1259    1090605    v_conference_room_users    TABLE     &  CREATE TABLE public.v_conference_room_users (
    domain_uuid uuid,
    conference_room_user_uuid uuid NOT NULL,
    conference_room_uuid uuid,
    user_uuid uuid,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
 +   DROP TABLE public.v_conference_room_users;
       public         heap 	   fusionpbx    false    5            �            1259    1090608    v_conference_rooms    TABLE     �  CREATE TABLE public.v_conference_rooms (
    domain_uuid uuid,
    conference_room_uuid uuid NOT NULL,
    conference_center_uuid uuid,
    conference_room_name text,
    profile text,
    record text,
    moderator_pin text,
    participant_pin text,
    max_members numeric,
    start_datetime text,
    stop_datetime text,
    wait_mod text,
    moderator_endconf text,
    announce_name text,
    announce_count text,
    announce_recording text,
    sounds text,
    mute text,
    created text,
    created_by text,
    email_address text,
    account_code text,
    enabled text,
    description text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
 &   DROP TABLE public.v_conference_rooms;
       public         heap 	   fusionpbx    false    5            �            1259    1090613    v_conference_session_details    TABLE     �  CREATE TABLE public.v_conference_session_details (
    domain_uuid uuid,
    conference_session_detail_uuid uuid NOT NULL,
    conference_session_uuid uuid,
    meeting_uuid uuid,
    username text,
    caller_id_name text,
    caller_id_number text,
    uuid uuid,
    moderator text,
    network_addr text,
    start_epoch numeric,
    end_epoch numeric,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
 0   DROP TABLE public.v_conference_session_details;
       public         heap 	   fusionpbx    false    5            �            1259    1090618    v_conference_sessions    TABLE     \  CREATE TABLE public.v_conference_sessions (
    domain_uuid uuid,
    conference_session_uuid uuid NOT NULL,
    meeting_uuid uuid,
    profile text,
    recording text,
    start_epoch numeric,
    end_epoch numeric,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
 )   DROP TABLE public.v_conference_sessions;
       public         heap 	   fusionpbx    false    5            �            1259    1090623    v_conference_users    TABLE       CREATE TABLE public.v_conference_users (
    conference_user_uuid uuid NOT NULL,
    domain_uuid uuid,
    conference_uuid uuid,
    user_uuid uuid,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
 &   DROP TABLE public.v_conference_users;
       public         heap 	   fusionpbx    false    5            �            1259    1090626    v_conferences    TABLE     )  CREATE TABLE public.v_conferences (
    domain_uuid uuid,
    conference_uuid uuid NOT NULL,
    dialplan_uuid uuid,
    conference_name text,
    conference_extension text,
    conference_pin_number text,
    conference_profile text,
    conference_email_address text,
    conference_account_code text,
    conference_flags text,
    conference_order numeric,
    conference_description text,
    conference_enabled text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
 !   DROP TABLE public.v_conferences;
       public         heap 	   fusionpbx    false    5            �            1259    1090631    v_contact_addresses    TABLE     ^  CREATE TABLE public.v_contact_addresses (
    contact_address_uuid uuid NOT NULL,
    domain_uuid uuid,
    contact_uuid uuid,
    address_type text,
    address_label text,
    address_primary numeric,
    address_street text,
    address_extended text,
    address_community text,
    address_locality text,
    address_region text,
    address_postal_code text,
    address_country text,
    address_latitude text,
    address_longitude text,
    address_description text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
 '   DROP TABLE public.v_contact_addresses;
       public         heap 	   fusionpbx    false    5            �            1259    1090636    v_contact_attachments    TABLE     �  CREATE TABLE public.v_contact_attachments (
    contact_attachment_uuid uuid NOT NULL,
    domain_uuid uuid,
    contact_uuid uuid,
    attachment_primary numeric,
    attachment_filename text,
    attachment_content text,
    attachment_description text,
    attachment_uploaded_date timestamp with time zone,
    attachment_uploaded_user_uuid uuid,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
 )   DROP TABLE public.v_contact_attachments;
       public         heap 	   fusionpbx    false    5            �            1259    1090641    v_contact_emails    TABLE     a  CREATE TABLE public.v_contact_emails (
    contact_email_uuid uuid NOT NULL,
    domain_uuid uuid,
    contact_uuid uuid,
    email_label text,
    email_primary numeric,
    email_address text,
    email_description text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
 $   DROP TABLE public.v_contact_emails;
       public         heap 	   fusionpbx    false    5            �            1259    1090646    v_contact_groups    TABLE       CREATE TABLE public.v_contact_groups (
    contact_group_uuid uuid NOT NULL,
    domain_uuid uuid,
    contact_uuid uuid,
    group_uuid uuid,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
 $   DROP TABLE public.v_contact_groups;
       public         heap 	   fusionpbx    false    5            �            1259    1090649    v_contact_notes    TABLE     A  CREATE TABLE public.v_contact_notes (
    contact_note_uuid uuid NOT NULL,
    domain_uuid uuid,
    contact_uuid uuid,
    contact_note text,
    last_mod_date text,
    last_mod_user text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
 #   DROP TABLE public.v_contact_notes;
       public         heap 	   fusionpbx    false    5            �            1259    1090654    v_contact_phones    TABLE     *  CREATE TABLE public.v_contact_phones (
    contact_phone_uuid uuid NOT NULL,
    domain_uuid uuid,
    contact_uuid uuid,
    phone_label text,
    phone_type_voice numeric,
    phone_type_fax numeric,
    phone_type_video numeric,
    phone_type_text numeric,
    phone_speed_dial text,
    phone_country_code numeric,
    phone_number text,
    phone_extension text,
    phone_primary numeric,
    phone_description text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
 $   DROP TABLE public.v_contact_phones;
       public         heap 	   fusionpbx    false    5            �            1259    1090659    v_contact_relations    TABLE     ;  CREATE TABLE public.v_contact_relations (
    contact_relation_uuid uuid NOT NULL,
    domain_uuid uuid,
    contact_uuid uuid,
    relation_label text,
    relation_contact_uuid uuid,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
 '   DROP TABLE public.v_contact_relations;
       public         heap 	   fusionpbx    false    5            �            1259    1090664    v_contact_settings    TABLE     �  CREATE TABLE public.v_contact_settings (
    contact_setting_uuid uuid NOT NULL,
    contact_uuid uuid,
    domain_uuid uuid,
    contact_setting_category text,
    contact_setting_subcategory text,
    contact_setting_name text,
    contact_setting_value text,
    contact_setting_order numeric,
    contact_setting_enabled text,
    contact_setting_description text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
 &   DROP TABLE public.v_contact_settings;
       public         heap 	   fusionpbx    false    5            �            1259    1090669    v_contact_times    TABLE     z  CREATE TABLE public.v_contact_times (
    domain_uuid uuid,
    contact_time_uuid uuid NOT NULL,
    contact_uuid uuid,
    user_uuid uuid,
    time_start timestamp with time zone,
    time_stop timestamp with time zone,
    time_description text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
 #   DROP TABLE public.v_contact_times;
       public         heap 	   fusionpbx    false    5            �            1259    1090674    v_contact_urls    TABLE     h  CREATE TABLE public.v_contact_urls (
    contact_url_uuid uuid NOT NULL,
    domain_uuid uuid,
    contact_uuid uuid,
    url_type text,
    url_label text,
    url_primary numeric,
    url_address text,
    url_description text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
 "   DROP TABLE public.v_contact_urls;
       public         heap 	   fusionpbx    false    5            �            1259    1090679    v_contact_users    TABLE       CREATE TABLE public.v_contact_users (
    contact_user_uuid uuid NOT NULL,
    domain_uuid uuid,
    contact_uuid uuid,
    user_uuid uuid,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
 #   DROP TABLE public.v_contact_users;
       public         heap 	   fusionpbx    false    5            �            1259    1090682 
   v_contacts    TABLE     �  CREATE TABLE public.v_contacts (
    contact_uuid uuid NOT NULL,
    domain_uuid uuid,
    contact_parent_uuid uuid,
    contact_type text,
    contact_organization text,
    contact_name_prefix text,
    contact_name_given text,
    contact_name_middle text,
    contact_name_family text,
    contact_name_suffix text,
    contact_nickname text,
    contact_title text,
    contact_role text,
    contact_category text,
    contact_url text,
    contact_time_zone text,
    contact_note text,
    last_mod_date text,
    last_mod_user text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
    DROP TABLE public.v_contacts;
       public         heap 	   fusionpbx    false    5            �            1259    1090687    v_countries    TABLE        CREATE TABLE public.v_countries (
    country_uuid uuid NOT NULL,
    country text,
    iso_a2 text,
    iso_a3 text,
    num numeric,
    country_code text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
    DROP TABLE public.v_countries;
       public         heap 	   fusionpbx    false    5            �            1259    1090692    v_dashboard    TABLE     �  CREATE TABLE public.v_dashboard (
    dashboard_uuid uuid NOT NULL,
    dashboard_name text,
    dashboard_path text,
    dashboard_column_span numeric,
    dashboard_order numeric,
    dashboard_enabled boolean,
    dashboard_description text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid,
    dashboard_details_state text
);
    DROP TABLE public.v_dashboard;
       public         heap 	   fusionpbx    false    5            �            1259    1090697    v_dashboard_groups    TABLE       CREATE TABLE public.v_dashboard_groups (
    dashboard_group_uuid uuid NOT NULL,
    dashboard_uuid uuid,
    group_uuid uuid,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
 &   DROP TABLE public.v_dashboard_groups;
       public         heap 	   fusionpbx    false    5            �            1259    1090700    v_database_transactions    TABLE       CREATE TABLE public.v_database_transactions (
    domain_uuid uuid,
    database_transaction_uuid uuid NOT NULL,
    user_uuid uuid,
    app_name text,
    app_uuid uuid,
    transaction_code text,
    transaction_address text,
    transaction_type text,
    transaction_date timestamp with time zone,
    transaction_old text,
    transaction_new text,
    transaction_result text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
 +   DROP TABLE public.v_database_transactions;
       public         heap 	   fusionpbx    false    5            �            1259    1090705    v_databases    TABLE     �  CREATE TABLE public.v_databases (
    database_uuid uuid NOT NULL,
    database_driver text,
    database_type text,
    database_host text,
    database_port text,
    database_name text,
    database_username text,
    database_password text,
    database_path text,
    database_description text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
    DROP TABLE public.v_databases;
       public         heap 	   fusionpbx    false    5            �            1259    1090710    v_default_settings    TABLE     �  CREATE TABLE public.v_default_settings (
    default_setting_uuid uuid NOT NULL,
    app_uuid uuid,
    default_setting_category text,
    default_setting_subcategory text,
    default_setting_name text,
    default_setting_value text,
    default_setting_order numeric,
    default_setting_enabled boolean,
    default_setting_description text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
 &   DROP TABLE public.v_default_settings;
       public         heap 	   fusionpbx    false    5                        1259    1090715    v_destinations    TABLE     �  CREATE TABLE public.v_destinations (
    domain_uuid uuid,
    destination_uuid uuid NOT NULL,
    dialplan_uuid uuid,
    fax_uuid uuid,
    user_uuid uuid,
    group_uuid uuid,
    destination_type text,
    destination_number text,
    destination_trunk_prefix text,
    destination_area_code text,
    destination_prefix text,
    destination_condition_field text,
    destination_number_regex text,
    destination_caller_id_name text,
    destination_caller_id_number text,
    destination_cid_name_prefix text,
    destination_context text,
    destination_record text,
    destination_hold_music text,
    destination_distinctive_ring text,
    destination_accountcode text,
    destination_type_voice numeric,
    destination_type_fax numeric,
    destination_type_emergency numeric,
    destination_type_text numeric,
    destination_conditions json,
    destination_actions json,
    destination_app text,
    destination_data text,
    destination_alternate_app text,
    destination_alternate_data text,
    destination_order numeric,
    destination_enabled text,
    destination_description text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
 "   DROP TABLE public.v_destinations;
       public         heap 	   fusionpbx    false    5                       1259    1090720    v_device_keys    TABLE     ,  CREATE TABLE public.v_device_keys (
    domain_uuid uuid,
    device_key_uuid uuid NOT NULL,
    device_uuid uuid,
    device_key_id numeric,
    device_key_category text,
    device_key_vendor text,
    device_key_type text,
    device_key_line numeric,
    device_key_value text,
    device_key_extension text,
    device_key_protected text,
    device_key_label text,
    device_key_icon text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid,
    device_key_subtype text
);
 !   DROP TABLE public.v_device_keys;
       public         heap 	   fusionpbx    false    5                       1259    1090725    v_device_lines    TABLE     �  CREATE TABLE public.v_device_lines (
    domain_uuid uuid,
    device_line_uuid uuid NOT NULL,
    device_uuid uuid,
    line_number text,
    server_address text,
    server_address_primary text,
    server_address_secondary text,
    outbound_proxy_primary text,
    outbound_proxy_secondary text,
    label text,
    display_name text,
    user_id text,
    auth_id text,
    password text,
    sip_port numeric,
    sip_transport text,
    register_expires numeric,
    shared_line text,
    enabled text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
 "   DROP TABLE public.v_device_lines;
       public         heap 	   fusionpbx    false    5                       1259    1090730    v_device_profile_keys    TABLE     O  CREATE TABLE public.v_device_profile_keys (
    device_profile_key_uuid uuid NOT NULL,
    domain_uuid uuid,
    device_profile_uuid uuid,
    profile_key_id numeric,
    profile_key_category text,
    profile_key_vendor text,
    profile_key_type text,
    profile_key_line numeric,
    profile_key_value text,
    profile_key_extension text,
    profile_key_protected text,
    profile_key_label text,
    profile_key_icon text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid,
    profile_key_subtype text
);
 )   DROP TABLE public.v_device_profile_keys;
       public         heap 	   fusionpbx    false    5                       1259    1090735    v_device_profile_settings    TABLE     �  CREATE TABLE public.v_device_profile_settings (
    device_profile_setting_uuid uuid NOT NULL,
    domain_uuid uuid,
    device_profile_uuid uuid,
    profile_setting_name text,
    profile_setting_value text,
    profile_setting_enabled text,
    profile_setting_description text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
 -   DROP TABLE public.v_device_profile_settings;
       public         heap 	   fusionpbx    false    5                       1259    1090740    v_device_profiles    TABLE     K  CREATE TABLE public.v_device_profiles (
    device_profile_uuid uuid NOT NULL,
    domain_uuid uuid,
    device_profile_name text,
    device_profile_enabled text,
    device_profile_description text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
 %   DROP TABLE public.v_device_profiles;
       public         heap 	   fusionpbx    false    5                       1259    1090745    v_device_settings    TABLE     �  CREATE TABLE public.v_device_settings (
    device_setting_uuid uuid NOT NULL,
    device_uuid uuid,
    domain_uuid uuid,
    device_setting_category text,
    device_setting_subcategory text,
    device_setting_name text,
    device_setting_value text,
    device_setting_enabled text,
    device_setting_description text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
 %   DROP TABLE public.v_device_settings;
       public         heap 	   fusionpbx    false    5                       1259    1090750    v_device_vendor_function_groups    TABLE     Z  CREATE TABLE public.v_device_vendor_function_groups (
    device_vendor_function_group_uuid uuid NOT NULL,
    device_vendor_function_uuid uuid,
    device_vendor_uuid uuid,
    group_name text,
    group_uuid uuid,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
 3   DROP TABLE public.v_device_vendor_function_groups;
       public         heap 	   fusionpbx    false    5                       1259    1090755    v_device_vendor_functions    TABLE     W  CREATE TABLE public.v_device_vendor_functions (
    device_vendor_function_uuid uuid NOT NULL,
    device_vendor_uuid uuid,
    type text,
    value text,
    enabled text,
    description text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid,
    subtype text
);
 -   DROP TABLE public.v_device_vendor_functions;
       public         heap 	   fusionpbx    false    5            	           1259    1090760    v_device_vendors    TABLE       CREATE TABLE public.v_device_vendors (
    device_vendor_uuid uuid NOT NULL,
    name text,
    enabled text,
    description text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
 $   DROP TABLE public.v_device_vendors;
       public         heap 	   fusionpbx    false    5            
           1259    1090765 	   v_devices    TABLE       CREATE TABLE public.v_devices (
    device_uuid uuid NOT NULL,
    domain_uuid uuid,
    device_profile_uuid uuid,
    device_address text,
    device_label text,
    device_vendor text,
    device_location text,
    device_model text,
    device_firmware_version text,
    device_enabled text,
    device_enabled_date timestamp with time zone,
    device_template text,
    device_user_uuid uuid,
    device_username text,
    device_password text,
    device_uuid_alternate uuid,
    device_description text,
    device_provisioned_date timestamp with time zone,
    device_provisioned_method text,
    device_provisioned_ip text,
    device_provisioned_agent text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
    DROP TABLE public.v_devices;
       public         heap 	   fusionpbx    false    5                       1259    1090770    v_dialplan_details    TABLE     	  CREATE TABLE public.v_dialplan_details (
    domain_uuid uuid,
    dialplan_uuid uuid,
    dialplan_detail_uuid uuid NOT NULL,
    dialplan_detail_tag text,
    dialplan_detail_type text,
    dialplan_detail_data text,
    dialplan_detail_break text,
    dialplan_detail_inline text,
    dialplan_detail_group numeric,
    dialplan_detail_order numeric,
    dialplan_detail_enabled boolean,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
 &   DROP TABLE public.v_dialplan_details;
       public         heap 	   fusionpbx    false    5                       1259    1090775    v_dialplans    TABLE     �  CREATE TABLE public.v_dialplans (
    domain_uuid uuid,
    dialplan_uuid uuid NOT NULL,
    app_uuid uuid,
    hostname text,
    dialplan_context text,
    dialplan_name text,
    dialplan_number text,
    dialplan_destination text,
    dialplan_continue text,
    dialplan_xml text,
    dialplan_order numeric,
    dialplan_enabled text,
    dialplan_description text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
    DROP TABLE public.v_dialplans;
       public         heap 	   fusionpbx    false    5                       1259    1090780    v_domain_settings    TABLE     �  CREATE TABLE public.v_domain_settings (
    domain_uuid uuid,
    domain_setting_uuid uuid NOT NULL,
    app_uuid uuid,
    domain_setting_category text,
    domain_setting_subcategory text,
    domain_setting_name text,
    domain_setting_value text,
    domain_setting_order numeric,
    domain_setting_enabled boolean,
    domain_setting_description text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
 %   DROP TABLE public.v_domain_settings;
       public         heap 	   fusionpbx    false    5                       1259    1090785 	   v_domains    TABLE     -  CREATE TABLE public.v_domains (
    domain_uuid uuid NOT NULL,
    domain_parent_uuid uuid,
    domain_name text,
    domain_enabled boolean,
    domain_description text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
    DROP TABLE public.v_domains;
       public         heap 	   fusionpbx    false    5                       1259    1090790    v_email_logs    TABLE     I  CREATE TABLE public.v_email_logs (
    email_log_uuid uuid NOT NULL,
    call_uuid uuid,
    domain_uuid uuid,
    sent_date timestamp with time zone,
    type text,
    status text,
    email text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
     DROP TABLE public.v_email_logs;
       public         heap 	   fusionpbx    false    5                       1259    1090795    v_email_queue    TABLE     .  CREATE TABLE public.v_email_queue (
    email_queue_uuid uuid NOT NULL,
    domain_uuid uuid,
    hostname text,
    email_date timestamp with time zone,
    email_from text,
    email_to text,
    email_subject text,
    email_body text,
    email_status text,
    email_retry_count numeric,
    email_action_before text,
    email_action_after text,
    email_uuid uuid,
    email_transcription text,
    email_response text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
 !   DROP TABLE public.v_email_queue;
       public         heap 	   fusionpbx    false    5                       1259    1090800    v_email_queue_attachments    TABLE     �  CREATE TABLE public.v_email_queue_attachments (
    email_queue_attachment_uuid uuid NOT NULL,
    domain_uuid uuid,
    email_queue_uuid uuid,
    email_attachment_type text,
    email_attachment_path text,
    email_attachment_name text,
    email_attachment_base64 text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid,
    email_attachment_mime_type text,
    email_attachment_cid text
);
 -   DROP TABLE public.v_email_queue_attachments;
       public         heap 	   fusionpbx    false    5                       1259    1090805    v_email_templates    TABLE     �  CREATE TABLE public.v_email_templates (
    email_template_uuid uuid NOT NULL,
    domain_uuid uuid,
    template_language text,
    template_category text,
    template_subcategory text,
    template_subject text,
    template_body text,
    template_type text,
    template_enabled text,
    template_description text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
 %   DROP TABLE public.v_email_templates;
       public         heap 	   fusionpbx    false    5                       1259    1090810    v_event_guard_logs    TABLE     q  CREATE TABLE public.v_event_guard_logs (
    event_guard_log_uuid uuid NOT NULL,
    hostname text,
    log_date timestamp with time zone,
    filter text,
    ip_address text,
    extension text,
    user_agent text,
    log_status text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
 &   DROP TABLE public.v_event_guard_logs;
       public         heap 	   fusionpbx    false    5                       1259    1090815    v_extension_settings    TABLE     �  CREATE TABLE public.v_extension_settings (
    extension_setting_uuid uuid NOT NULL,
    domain_uuid uuid,
    extension_uuid uuid,
    extension_setting_type text,
    extension_setting_name text,
    extension_setting_value text,
    extension_setting_enabled boolean,
    extension_setting_description text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
 (   DROP TABLE public.v_extension_settings;
       public         heap 	   fusionpbx    false    5                       1259    1090820    v_extension_users    TABLE       CREATE TABLE public.v_extension_users (
    extension_user_uuid uuid NOT NULL,
    domain_uuid uuid,
    extension_uuid uuid,
    user_uuid uuid,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
 %   DROP TABLE public.v_extension_users;
       public         heap 	   fusionpbx    false    5                       1259    1090823    v_extensions    TABLE     �  CREATE TABLE public.v_extensions (
    extension_uuid uuid NOT NULL,
    domain_uuid uuid,
    extension text,
    number_alias text,
    password text,
    accountcode text,
    effective_caller_id_name text,
    effective_caller_id_number text,
    outbound_caller_id_name text,
    outbound_caller_id_number text,
    emergency_caller_id_name text,
    emergency_caller_id_number text,
    directory_first_name text,
    directory_last_name text,
    directory_visible text,
    directory_exten_visible text,
    max_registrations text,
    limit_max text,
    limit_destination text,
    missed_call_app text,
    missed_call_data text,
    user_context text,
    toll_allow text,
    call_timeout numeric,
    call_group text,
    call_screen_enabled text,
    user_record text,
    hold_music text,
    auth_acl text,
    cidr text,
    sip_force_contact text,
    nibble_account text,
    sip_force_expires numeric,
    mwi_account text,
    sip_bypass_media text,
    unique_id numeric,
    dial_string text,
    dial_user text,
    dial_domain text,
    do_not_disturb text,
    forward_all_destination text,
    forward_all_enabled text,
    forward_busy_destination text,
    forward_busy_enabled text,
    forward_no_answer_destination text,
    forward_no_answer_enabled text,
    forward_user_not_registered_destination text,
    forward_user_not_registered_enabled text,
    follow_me_uuid uuid,
    follow_me_enabled text,
    follow_me_destinations text,
    enabled text,
    description text,
    absolute_codec_string text,
    force_ping text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid,
    extension_type text
);
     DROP TABLE public.v_extensions;
       public         heap 	   fusionpbx    false    5                       1259    1090828    v_fax    TABLE       CREATE TABLE public.v_fax (
    fax_uuid uuid NOT NULL,
    domain_uuid uuid,
    dialplan_uuid uuid,
    fax_extension text,
    fax_destination_number text,
    fax_prefix text,
    fax_name text,
    fax_email text,
    fax_email_connection_type text,
    fax_email_connection_host text,
    fax_email_connection_port text,
    fax_email_connection_security text,
    fax_email_connection_validate text,
    fax_email_connection_username text,
    fax_email_connection_password text,
    fax_email_connection_mailbox text,
    fax_email_inbound_subject_tag text,
    fax_email_outbound_subject_tag text,
    fax_email_outbound_authorized_senders text,
    fax_pin_number text,
    fax_caller_id_name text,
    fax_caller_id_number text,
    fax_toll_allow text,
    fax_forward_number text,
    fax_send_greeting text,
    fax_send_channels numeric,
    fax_description text,
    accountcode text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
    DROP TABLE public.v_fax;
       public         heap 	   fusionpbx    false    5                       1259    1090833    v_fax_files    TABLE     �  CREATE TABLE public.v_fax_files (
    domain_uuid uuid,
    fax_file_uuid uuid NOT NULL,
    fax_uuid uuid,
    fax_mode text,
    fax_destination text,
    fax_file_type text,
    fax_file_path text,
    fax_caller_id_name text,
    fax_caller_id_number text,
    fax_date timestamp with time zone,
    fax_epoch numeric,
    fax_base64 text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
    DROP TABLE public.v_fax_files;
       public         heap 	   fusionpbx    false    5                       1259    1090838 
   v_fax_logs    TABLE       CREATE TABLE public.v_fax_logs (
    fax_log_uuid uuid NOT NULL,
    domain_uuid uuid,
    fax_uuid uuid,
    fax_success text,
    fax_result_code numeric,
    fax_result_text text,
    fax_file text,
    fax_ecm_used text,
    fax_local_station_id text,
    fax_document_transferred_pages numeric,
    fax_document_total_pages numeric,
    fax_image_resolution text,
    fax_image_size numeric,
    fax_bad_rows numeric,
    fax_transfer_rate numeric,
    fax_retry_attempts numeric,
    fax_retry_limit numeric,
    fax_retry_sleep numeric,
    fax_uri text,
    fax_duration numeric,
    fax_date timestamp with time zone,
    fax_epoch numeric,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
    DROP TABLE public.v_fax_logs;
       public         heap 	   fusionpbx    false    5                       1259    1090843    v_fax_queue    TABLE     �  CREATE TABLE public.v_fax_queue (
    fax_queue_uuid uuid NOT NULL,
    domain_uuid uuid,
    fax_uuid uuid,
    origination_uuid uuid,
    fax_log_uuid uuid,
    fax_date timestamp with time zone,
    hostname text,
    fax_caller_id_name text,
    fax_caller_id_number text,
    fax_number text,
    fax_prefix text,
    fax_email_address text,
    fax_file text,
    fax_status text,
    fax_retry_date timestamp with time zone,
    fax_notify_sent boolean,
    fax_notify_date timestamp with time zone,
    fax_retry_count numeric,
    fax_accountcode text,
    fax_command text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
    DROP TABLE public.v_fax_queue;
       public         heap 	   fusionpbx    false    5                       1259    1090848    v_fax_tasks    TABLE     ~  CREATE TABLE public.v_fax_tasks (
    fax_task_uuid uuid NOT NULL,
    fax_uuid uuid,
    task_next_time timestamp with time zone,
    task_lock_time timestamp with time zone,
    task_fax_file text,
    task_wav_file text,
    task_uri text,
    task_dial_string text,
    task_dtmf text,
    task_reply_address text,
    task_interrupted text,
    task_status numeric,
    task_no_answer_counter numeric,
    task_no_answer_retry_counter numeric,
    task_retry_counter numeric,
    task_description text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
    DROP TABLE public.v_fax_tasks;
       public         heap 	   fusionpbx    false    5                       1259    1090853    v_fax_users    TABLE       CREATE TABLE public.v_fax_users (
    fax_user_uuid uuid NOT NULL,
    domain_uuid uuid,
    fax_uuid uuid,
    user_uuid uuid,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
    DROP TABLE public.v_fax_users;
       public         heap 	   fusionpbx    false    5                       1259    1090856    v_follow_me    TABLE     d  CREATE TABLE public.v_follow_me (
    domain_uuid uuid,
    follow_me_uuid uuid NOT NULL,
    cid_name_prefix text,
    cid_number_prefix text,
    dial_string text,
    follow_me_enabled text,
    follow_me_ignore_busy text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
    DROP TABLE public.v_follow_me;
       public         heap 	   fusionpbx    false    5                       1259    1090861    v_follow_me_destinations    TABLE     �  CREATE TABLE public.v_follow_me_destinations (
    domain_uuid uuid,
    follow_me_uuid uuid,
    follow_me_destination_uuid uuid NOT NULL,
    follow_me_destination text,
    follow_me_delay numeric,
    follow_me_timeout numeric,
    follow_me_prompt text,
    follow_me_order numeric,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
 ,   DROP TABLE public.v_follow_me_destinations;
       public         heap 	   fusionpbx    false    5                       1259    1090866 
   v_gateways    TABLE     �  CREATE TABLE public.v_gateways (
    gateway_uuid uuid NOT NULL,
    domain_uuid uuid,
    gateway text,
    username text,
    password text,
    distinct_to text,
    auth_username text,
    realm text,
    from_user text,
    from_domain text,
    proxy text,
    register_proxy text,
    outbound_proxy text,
    expire_seconds numeric,
    register text,
    register_transport text,
    retry_seconds numeric,
    extension text,
    ping text,
    ping_min text,
    ping_max text,
    contact_in_ping text,
    caller_id_in_from text,
    supress_cng text,
    sip_cid_type text,
    codec_prefs text,
    channels numeric,
    extension_in_contact text,
    context text,
    profile text,
    hostname text,
    enabled text,
    description text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid,
    contact_params text
);
    DROP TABLE public.v_gateways;
       public         heap 	   fusionpbx    false    5                        1259    1090871    v_group_permissions    TABLE     l  CREATE TABLE public.v_group_permissions (
    group_permission_uuid uuid NOT NULL,
    domain_uuid uuid,
    permission_name text,
    permission_protected text,
    permission_assigned text,
    group_name text,
    group_uuid uuid,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
 '   DROP TABLE public.v_group_permissions;
       public         heap 	   fusionpbx    false    5            !           1259    1090876    v_groups    TABLE     9  CREATE TABLE public.v_groups (
    group_uuid uuid NOT NULL,
    domain_uuid uuid,
    group_name text,
    group_protected text,
    group_level numeric,
    group_description text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
    DROP TABLE public.v_groups;
       public         heap 	   fusionpbx    false    5            "           1259    1090881    v_ivr_menu_options    TABLE     �  CREATE TABLE public.v_ivr_menu_options (
    ivr_menu_option_uuid uuid NOT NULL,
    ivr_menu_uuid uuid,
    domain_uuid uuid,
    ivr_menu_option_digits text,
    ivr_menu_option_action text,
    ivr_menu_option_param text,
    ivr_menu_option_order numeric,
    ivr_menu_option_description text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid,
    ivr_menu_option_enabled boolean
);
 &   DROP TABLE public.v_ivr_menu_options;
       public         heap 	   fusionpbx    false    5            #           1259    1090886    v_ivr_menus    TABLE     h  CREATE TABLE public.v_ivr_menus (
    ivr_menu_uuid uuid NOT NULL,
    domain_uuid uuid,
    dialplan_uuid uuid,
    ivr_menu_name text,
    ivr_menu_extension text,
    ivr_menu_parent_uuid uuid,
    ivr_menu_language text,
    ivr_menu_dialect text,
    ivr_menu_voice text,
    ivr_menu_greet_long text,
    ivr_menu_greet_short text,
    ivr_menu_invalid_sound text,
    ivr_menu_exit_sound text,
    ivr_menu_pin_number text,
    ivr_menu_confirm_macro text,
    ivr_menu_confirm_key text,
    ivr_menu_tts_engine text,
    ivr_menu_tts_voice text,
    ivr_menu_confirm_attempts numeric,
    ivr_menu_timeout numeric,
    ivr_menu_exit_app text,
    ivr_menu_exit_data text,
    ivr_menu_inter_digit_timeout numeric,
    ivr_menu_max_failures numeric,
    ivr_menu_max_timeouts numeric,
    ivr_menu_digit_len numeric,
    ivr_menu_direct_dial text,
    ivr_menu_ringback text,
    ivr_menu_cid_prefix text,
    ivr_menu_context text,
    ivr_menu_enabled text,
    ivr_menu_description text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
    DROP TABLE public.v_ivr_menus;
       public         heap 	   fusionpbx    false    5            $           1259    1090891    v_languages    TABLE     �   CREATE TABLE public.v_languages (
    language_uuid uuid NOT NULL,
    language text,
    code text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
    DROP TABLE public.v_languages;
       public         heap 	   fusionpbx    false    5            %           1259    1090896    v_menu_item_groups    TABLE     *  CREATE TABLE public.v_menu_item_groups (
    menu_item_group_uuid uuid NOT NULL,
    menu_uuid uuid,
    menu_item_uuid uuid,
    group_name text,
    group_uuid uuid,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
 &   DROP TABLE public.v_menu_item_groups;
       public         heap 	   fusionpbx    false    5            &           1259    1090901    v_menu_items    TABLE     B  CREATE TABLE public.v_menu_items (
    menu_item_uuid uuid NOT NULL,
    menu_uuid uuid,
    menu_item_parent_uuid uuid,
    uuid uuid,
    menu_item_title text,
    menu_item_link text,
    menu_item_icon text,
    menu_item_category text,
    menu_item_protected text,
    menu_item_order numeric,
    menu_item_description text,
    menu_item_add_user text,
    menu_item_add_date text,
    menu_item_mod_user text,
    menu_item_mod_date text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
     DROP TABLE public.v_menu_items;
       public         heap 	   fusionpbx    false    5            '           1259    1090906    v_menu_languages    TABLE     .  CREATE TABLE public.v_menu_languages (
    menu_language_uuid uuid NOT NULL,
    menu_uuid uuid,
    menu_item_uuid uuid,
    menu_language text,
    menu_item_title text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
 $   DROP TABLE public.v_menu_languages;
       public         heap 	   fusionpbx    false    5            (           1259    1090911    v_menus    TABLE       CREATE TABLE public.v_menus (
    menu_uuid uuid NOT NULL,
    menu_name text,
    menu_language text,
    menu_description text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
    DROP TABLE public.v_menus;
       public         heap 	   fusionpbx    false    5            )           1259    1090916 	   v_modules    TABLE     y  CREATE TABLE public.v_modules (
    module_uuid uuid NOT NULL,
    module_label text,
    module_name text,
    module_category text,
    module_order numeric,
    module_enabled text,
    module_default_enabled text,
    module_description text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
    DROP TABLE public.v_modules;
       public         heap 	   fusionpbx    false    5            *           1259    1090921    v_music_on_hold    TABLE     7  CREATE TABLE public.v_music_on_hold (
    music_on_hold_uuid uuid NOT NULL,
    domain_uuid uuid,
    music_on_hold_name text,
    music_on_hold_path text,
    music_on_hold_rate numeric,
    music_on_hold_shuffle text,
    music_on_hold_channels numeric,
    music_on_hold_interval numeric,
    music_on_hold_timer_name text,
    music_on_hold_chime_list text,
    music_on_hold_chime_freq numeric,
    music_on_hold_chime_max numeric,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
 #   DROP TABLE public.v_music_on_hold;
       public         heap 	   fusionpbx    false    5            +           1259    1090926    v_notifications    TABLE     �   CREATE TABLE public.v_notifications (
    notification_uuid uuid NOT NULL,
    project_notifications text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
 #   DROP TABLE public.v_notifications;
       public         heap 	   fusionpbx    false    5            ,           1259    1090931    v_number_translation_details    TABLE     �  CREATE TABLE public.v_number_translation_details (
    number_translation_detail_uuid uuid NOT NULL,
    number_translation_uuid uuid,
    number_translation_detail_regex text,
    number_translation_detail_replace text,
    number_translation_detail_order text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
 0   DROP TABLE public.v_number_translation_details;
       public         heap 	   fusionpbx    false    5            -           1259    1090936    v_number_translations    TABLE     I  CREATE TABLE public.v_number_translations (
    number_translation_uuid uuid NOT NULL,
    number_translation_name text,
    number_translation_enabled text,
    number_translation_description text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
 )   DROP TABLE public.v_number_translations;
       public         heap 	   fusionpbx    false    5            .           1259    1090941    v_permissions    TABLE     :  CREATE TABLE public.v_permissions (
    permission_uuid uuid NOT NULL,
    application_uuid uuid,
    application_name text,
    permission_name text,
    permission_description text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
 !   DROP TABLE public.v_permissions;
       public         heap 	   fusionpbx    false    5            /           1259    1090946    v_phrase_details    TABLE     �  CREATE TABLE public.v_phrase_details (
    phrase_detail_uuid uuid NOT NULL,
    phrase_uuid uuid,
    domain_uuid uuid,
    phrase_detail_group numeric,
    phrase_detail_tag text,
    phrase_detail_pattern text,
    phrase_detail_function text,
    phrase_detail_data text,
    phrase_detail_method text,
    phrase_detail_type text,
    phrase_detail_order text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
 $   DROP TABLE public.v_phrase_details;
       public         heap 	   fusionpbx    false    5            0           1259    1090951 	   v_phrases    TABLE     =  CREATE TABLE public.v_phrases (
    phrase_uuid uuid NOT NULL,
    domain_uuid uuid,
    phrase_name text,
    phrase_language text,
    phrase_enabled text,
    phrase_description text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
    DROP TABLE public.v_phrases;
       public         heap 	   fusionpbx    false    5            1           1259    1090956    v_pin_numbers    TABLE     2  CREATE TABLE public.v_pin_numbers (
    domain_uuid uuid,
    pin_number_uuid uuid NOT NULL,
    pin_number text,
    accountcode text,
    enabled text,
    description text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
 !   DROP TABLE public.v_pin_numbers;
       public         heap 	   fusionpbx    false    5            2           1259    1090961    v_recordings    TABLE     N  CREATE TABLE public.v_recordings (
    recording_uuid uuid NOT NULL,
    domain_uuid uuid,
    recording_filename text,
    recording_name text,
    recording_description text,
    recording_base64 text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
     DROP TABLE public.v_recordings;
       public         heap 	   fusionpbx    false    5            3           1259    1090966    v_ring_group_destinations    TABLE     �  CREATE TABLE public.v_ring_group_destinations (
    ring_group_destination_uuid uuid NOT NULL,
    domain_uuid uuid,
    ring_group_uuid uuid,
    destination_number text,
    destination_delay numeric,
    destination_timeout numeric,
    destination_prompt numeric,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid,
    destination_enabled boolean
);
 -   DROP TABLE public.v_ring_group_destinations;
       public         heap 	   fusionpbx    false    5            4           1259    1090971    v_ring_group_users    TABLE       CREATE TABLE public.v_ring_group_users (
    ring_group_user_uuid uuid NOT NULL,
    domain_uuid uuid,
    ring_group_uuid uuid,
    user_uuid uuid,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
 &   DROP TABLE public.v_ring_group_users;
       public         heap 	   fusionpbx    false    5            5           1259    1090974    v_ring_groups    TABLE       CREATE TABLE public.v_ring_groups (
    domain_uuid uuid,
    ring_group_uuid uuid NOT NULL,
    ring_group_name text,
    ring_group_extension text,
    ring_group_greeting text,
    ring_group_context text,
    ring_group_call_timeout numeric,
    ring_group_forward_destination text,
    ring_group_forward_enabled text,
    ring_group_caller_id_name text,
    ring_group_caller_id_number text,
    ring_group_cid_name_prefix text,
    ring_group_cid_number_prefix text,
    ring_group_strategy text,
    ring_group_timeout_app text,
    ring_group_timeout_data text,
    ring_group_distinctive_ring text,
    ring_group_ringback text,
    ring_group_call_forward_enabled text,
    ring_group_follow_me_enabled text,
    ring_group_missed_call_app text,
    ring_group_missed_call_data text,
    ring_group_enabled text,
    ring_group_description text,
    dialplan_uuid uuid,
    ring_group_forward_toll_allow text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
 !   DROP TABLE public.v_ring_groups;
       public         heap 	   fusionpbx    false    5            6           1259    1090979 
   v_settings    TABLE       CREATE TABLE public.v_settings (
    setting_uuid uuid NOT NULL,
    numbering_plan text,
    event_socket_ip_address text,
    event_socket_port text,
    event_socket_password text,
    event_socket_acl text,
    xml_rpc_http_port text,
    xml_rpc_auth_realm text,
    xml_rpc_auth_user text,
    xml_rpc_auth_pass text,
    admin_pin numeric,
    mod_shout_decoder text,
    mod_shout_volume text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
    DROP TABLE public.v_settings;
       public         heap 	   fusionpbx    false    5            7           1259    1090984    v_sip_profile_domains    TABLE     \  CREATE TABLE public.v_sip_profile_domains (
    sip_profile_domain_uuid uuid NOT NULL,
    sip_profile_uuid uuid,
    sip_profile_domain_name text,
    sip_profile_domain_alias text,
    sip_profile_domain_parse text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
 )   DROP TABLE public.v_sip_profile_domains;
       public         heap 	   fusionpbx    false    5            8           1259    1090989    v_sip_profile_settings    TABLE     �  CREATE TABLE public.v_sip_profile_settings (
    sip_profile_setting_uuid uuid NOT NULL,
    sip_profile_uuid uuid,
    sip_profile_setting_name text,
    sip_profile_setting_value text,
    sip_profile_setting_enabled text,
    sip_profile_setting_description text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
 *   DROP TABLE public.v_sip_profile_settings;
       public         heap 	   fusionpbx    false    5            9           1259    1090994    v_sip_profiles    TABLE     E  CREATE TABLE public.v_sip_profiles (
    sip_profile_uuid uuid NOT NULL,
    sip_profile_name text,
    sip_profile_hostname text,
    sip_profile_enabled text,
    sip_profile_description text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
 "   DROP TABLE public.v_sip_profiles;
       public         heap 	   fusionpbx    false    5            :           1259    1090999    v_sofia_global_settings    TABLE     c  CREATE TABLE public.v_sofia_global_settings (
    sofia_global_setting_uuid uuid NOT NULL,
    global_setting_name text,
    global_setting_value text,
    global_setting_enabled boolean,
    global_setting_description text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
 +   DROP TABLE public.v_sofia_global_settings;
       public         heap 	   fusionpbx    false    5            ;           1259    1091004 
   v_software    TABLE       CREATE TABLE public.v_software (
    software_uuid uuid NOT NULL,
    software_name text,
    software_url text,
    software_version text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
    DROP TABLE public.v_software;
       public         heap 	   fusionpbx    false    5            <           1259    1091009 	   v_streams    TABLE     =  CREATE TABLE public.v_streams (
    stream_uuid uuid NOT NULL,
    domain_uuid uuid,
    stream_name text,
    stream_location text,
    stream_enabled text,
    stream_description text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
    DROP TABLE public.v_streams;
       public         heap 	   fusionpbx    false    5            =           1259    1091014    v_user_groups    TABLE       CREATE TABLE public.v_user_groups (
    user_group_uuid uuid NOT NULL,
    domain_uuid uuid,
    group_name text,
    group_uuid uuid,
    user_uuid uuid,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
 !   DROP TABLE public.v_user_groups;
       public         heap 	   fusionpbx    false    5            >           1259    1091019    v_user_logs    TABLE     z  CREATE TABLE public.v_user_logs (
    user_log_uuid uuid NOT NULL,
    domain_uuid uuid,
    "timestamp" timestamp with time zone,
    user_uuid uuid,
    username text,
    type text,
    result text,
    remote_address text,
    user_agent text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
    DROP TABLE public.v_user_logs;
       public         heap 	   fusionpbx    false    5            ?           1259    1091024    v_user_settings    TABLE     �  CREATE TABLE public.v_user_settings (
    user_setting_uuid uuid NOT NULL,
    user_uuid uuid,
    domain_uuid uuid,
    user_setting_category text,
    user_setting_subcategory text,
    user_setting_name text,
    user_setting_value text,
    user_setting_order numeric,
    user_setting_enabled boolean,
    user_setting_description text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
 #   DROP TABLE public.v_user_settings;
       public         heap 	   fusionpbx    false    5            @           1259    1091029    v_users    TABLE     �  CREATE TABLE public.v_users (
    user_uuid uuid NOT NULL,
    domain_uuid uuid,
    username text,
    password text,
    salt text,
    user_email text,
    contact_uuid uuid,
    user_status text,
    api_key text,
    user_enabled text,
    add_user text,
    add_date text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid,
    user_totp_secret text,
    user_type text
);
    DROP TABLE public.v_users;
       public         heap 	   fusionpbx    false    5            A           1259    1091034    v_vars    TABLE     m  CREATE TABLE public.v_vars (
    var_uuid uuid NOT NULL,
    var_category text,
    var_name text,
    var_value text,
    var_command text,
    var_hostname text,
    var_enabled text,
    var_order numeric,
    var_description text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
    DROP TABLE public.v_vars;
       public         heap 	   fusionpbx    false    5            B           1259    1091039    v_voicemail_destinations    TABLE     ,  CREATE TABLE public.v_voicemail_destinations (
    domain_uuid uuid,
    voicemail_destination_uuid uuid NOT NULL,
    voicemail_uuid uuid,
    voicemail_uuid_copy uuid,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
 ,   DROP TABLE public.v_voicemail_destinations;
       public         heap 	   fusionpbx    false    5            C           1259    1091042    v_voicemail_greetings    TABLE     �  CREATE TABLE public.v_voicemail_greetings (
    voicemail_greeting_uuid uuid NOT NULL,
    domain_uuid uuid,
    voicemail_id text,
    greeting_id numeric,
    greeting_name text,
    greeting_filename text,
    greeting_description text,
    greeting_base64 text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
 )   DROP TABLE public.v_voicemail_greetings;
       public         heap 	   fusionpbx    false    5            D           1259    1091047    v_voicemail_messages    TABLE       CREATE TABLE public.v_voicemail_messages (
    domain_uuid uuid,
    voicemail_message_uuid uuid NOT NULL,
    voicemail_uuid uuid,
    created_epoch numeric,
    read_epoch numeric,
    caller_id_name text,
    caller_id_number text,
    message_length numeric,
    message_status text,
    message_priority text,
    message_intro_base64 text,
    message_base64 text,
    message_transcription text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
 (   DROP TABLE public.v_voicemail_messages;
       public         heap 	   fusionpbx    false    5            E           1259    1091052    v_voicemail_options    TABLE     �  CREATE TABLE public.v_voicemail_options (
    voicemail_option_uuid uuid NOT NULL,
    domain_uuid uuid,
    voicemail_uuid uuid,
    voicemail_option_digits text,
    voicemail_option_action text,
    voicemail_option_param text,
    voicemail_option_order numeric,
    voicemail_option_description text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
 '   DROP TABLE public.v_voicemail_options;
       public         heap 	   fusionpbx    false    5            F           1259    1091057    v_voicemails    TABLE     �  CREATE TABLE public.v_voicemails (
    domain_uuid uuid,
    voicemail_uuid uuid NOT NULL,
    voicemail_id text,
    voicemail_password text,
    greeting_id numeric,
    voicemail_alternate_greet_id numeric,
    voicemail_mail_to text,
    voicemail_sms_to text,
    voicemail_transcription_enabled text,
    voicemail_attach_file text,
    voicemail_file text,
    voicemail_local_after_email text,
    voicemail_enabled text,
    voicemail_description text,
    voicemail_name_base64 text,
    voicemail_tutorial text,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid,
    voicemail_recording_instructions text,
    voicemail_recording_options text
);
     DROP TABLE public.v_voicemails;
       public         heap 	   fusionpbx    false    5            G           1259    1091062 	   v_xml_cdr    TABLE     j  CREATE TABLE public.v_xml_cdr (
    xml_cdr_uuid uuid NOT NULL,
    domain_uuid uuid,
    extension_uuid uuid,
    sip_call_id text,
    domain_name text,
    accountcode text,
    direction text,
    default_language text,
    context text,
    caller_id_name text,
    caller_id_number text,
    caller_destination text,
    source_number text,
    destination_number text,
    start_epoch numeric,
    start_stamp timestamp with time zone,
    answer_stamp timestamp with time zone,
    answer_epoch numeric,
    end_epoch numeric,
    end_stamp timestamp with time zone,
    duration numeric,
    mduration numeric,
    billsec numeric,
    billmsec numeric,
    bridge_uuid text,
    read_codec text,
    read_rate text,
    write_codec text,
    write_rate text,
    remote_media_ip text,
    network_addr text,
    record_path text,
    record_name text,
    record_length numeric,
    leg character(1),
    originating_leg_uuid uuid,
    pdd_ms numeric,
    rtp_audio_in_mos numeric,
    last_app text,
    last_arg text,
    voicemail_message boolean,
    missed_call boolean,
    call_center_queue_uuid uuid,
    cc_side text,
    cc_member_uuid uuid,
    cc_queue_joined_epoch numeric,
    cc_queue text,
    cc_member_session_uuid uuid,
    cc_agent_uuid uuid,
    cc_agent text,
    cc_agent_type text,
    cc_agent_bridged text,
    cc_queue_answered_epoch numeric,
    cc_queue_terminated_epoch numeric,
    cc_queue_canceled_epoch numeric,
    cc_cancel_reason text,
    cc_cause text,
    waitsec numeric,
    conference_name text,
    conference_uuid uuid,
    conference_member_id text,
    digits_dialed text,
    pin_number text,
    hangup_cause text,
    hangup_cause_q850 numeric,
    sip_hangup_disposition text,
    xml text,
    json jsonb,
    insert_date timestamp with time zone,
    insert_user uuid,
    update_date timestamp with time zone,
    update_user uuid
);
    DROP TABLE public.v_xml_cdr;
       public         heap 	   fusionpbx    false    5            H           1259    1091067    version    TABLE     }   CREATE TABLE public.version (
    table_name character varying(32) NOT NULL,
    table_version integer DEFAULT 0 NOT NULL
);
    DROP TABLE public.version;
       public         heap    postgres    false    5            I           1259    1091071    view_call_block    VIEW     �  CREATE VIEW public.view_call_block AS
 SELECT c.domain_uuid,
    c.call_block_uuid,
    c.call_block_direction,
    c.extension_uuid,
    c.call_block_name,
    c.call_block_country_code,
    c.call_block_number,
    e.extension,
    e.number_alias,
    c.call_block_count,
    c.call_block_app,
    c.call_block_data,
    c.date_added,
    c.call_block_enabled,
    c.call_block_description
   FROM (public.v_call_block c
     LEFT JOIN public.v_extensions e ON ((c.extension_uuid = e.extension_uuid)));
 "   DROP VIEW public.view_call_block;
       public       	   fusionpbx    false    221    221    221    221    221    278    278    278    221    221    221    221    221    221    221    221    5            J           1259    1091076    view_call_recordings    VIEW     �  CREATE VIEW public.view_call_recordings AS
 SELECT domain_uuid,
    xml_cdr_uuid AS call_recording_uuid,
    caller_id_name,
    caller_id_number,
    caller_destination,
    destination_number,
    record_name AS call_recording_name,
    record_path AS call_recording_path,
    duration AS call_recording_length,
    start_stamp AS call_recording_date,
    direction AS call_direction
   FROM public.v_xml_cdr
  WHERE ((record_name IS NOT NULL) AND (record_path IS NOT NULL))
  ORDER BY start_stamp DESC;
 '   DROP VIEW public.view_call_recordings;
       public       	   fusionpbx    false    327    327    327    327    327    327    327    327    327    327    327    5            K           1259    1091081    view_groups    VIEW     m  CREATE VIEW public.view_groups AS
 SELECT domain_uuid,
    group_uuid,
    group_name,
    ( SELECT v_domains.domain_name
           FROM public.v_domains
          WHERE (v_domains.domain_uuid = g.domain_uuid)) AS domain_name,
    ( SELECT count(*) AS count
           FROM public.v_group_permissions
          WHERE (v_group_permissions.group_uuid = g.group_uuid)) AS group_permissions,
    ( SELECT count(*) AS count
           FROM public.v_user_groups
          WHERE (v_user_groups.group_uuid = g.group_uuid)) AS group_members,
    group_level,
    group_protected,
    group_description
   FROM public.v_groups g;
    DROP VIEW public.view_groups;
       public       	   fusionpbx    false    270    288    289    289    289    289    289    289    317    270    5            L           1259    1091085 
   view_users    VIEW       CREATE VIEW public.view_users AS
 SELECT u.domain_uuid,
    u.user_uuid,
    d.domain_name,
    u.username,
    u.user_status,
    u.user_enabled,
    u.add_date,
    c.contact_uuid,
    c.contact_organization,
    ((c.contact_name_given || ' '::text) || c.contact_name_family) AS contact_name,
    c.contact_name_given,
    c.contact_name_family,
    ( SELECT string_agg(g.group_name, ', '::text) AS string_agg
           FROM public.v_user_groups ug,
            public.v_groups g
          WHERE ((ug.group_uuid = g.group_uuid) AND (u.user_uuid = ug.user_uuid))) AS group_names,
    ( SELECT string_agg((g.group_uuid)::text, ', '::text) AS string_agg
           FROM public.v_user_groups ug,
            public.v_groups g
          WHERE ((ug.group_uuid = g.group_uuid) AND (u.user_uuid = ug.user_uuid))) AS group_uuids,
    ( SELECT g.group_level
           FROM public.v_user_groups ug,
            public.v_groups g
          WHERE ((ug.group_uuid = g.group_uuid) AND (u.user_uuid = ug.user_uuid))
          ORDER BY g.group_level DESC
         LIMIT 1) AS group_level
   FROM ((public.v_contacts c
     RIGHT JOIN public.v_users u ON ((u.contact_uuid = c.contact_uuid)))
     JOIN public.v_domains d ON ((d.domain_uuid = u.domain_uuid)))
  WHERE (1 = 1)
  ORDER BY u.username;
    DROP VIEW public.view_users;
       public       	   fusionpbx    false    320    289    289    289    249    270    249    249    320    270    249    320    317    317    320    320    320    320    5            =           2604    1091090    fs_mapping id    DEFAULT     n   ALTER TABLE ONLY public.fs_mapping ALTER COLUMN id SET DEFAULT nextval('public.fs_mapping_id_seq'::regclass);
 <   ALTER TABLE public.fs_mapping ALTER COLUMN id DROP DEFAULT;
       public       	   fusionpbx    false    216    215            @           2606    2163983     fs_mapping fs_mapping_domain_key 
   CONSTRAINT     ]   ALTER TABLE ONLY public.fs_mapping
    ADD CONSTRAINT fs_mapping_domain_key UNIQUE (domain);
 J   ALTER TABLE ONLY public.fs_mapping DROP CONSTRAINT fs_mapping_domain_key;
       public         	   fusionpbx    false    215            B           2606    2163985    fs_mapping fs_mapping_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.fs_mapping
    ADD CONSTRAINT fs_mapping_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.fs_mapping DROP CONSTRAINT fs_mapping_pkey;
       public         	   fusionpbx    false    215            "           2606    2163987    version table_name_idx 
   CONSTRAINT     W   ALTER TABLE ONLY public.version
    ADD CONSTRAINT table_name_idx UNIQUE (table_name);
 @   ALTER TABLE ONLY public.version DROP CONSTRAINT table_name_idx;
       public            postgres    false    328            D           2606    2163989 2   v_access_control_nodes v_access_control_nodes_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.v_access_control_nodes
    ADD CONSTRAINT v_access_control_nodes_pkey PRIMARY KEY (access_control_node_uuid);
 \   ALTER TABLE ONLY public.v_access_control_nodes DROP CONSTRAINT v_access_control_nodes_pkey;
       public         	   fusionpbx    false    217            F           2606    2163991 (   v_access_controls v_access_controls_pkey 
   CONSTRAINT     w   ALTER TABLE ONLY public.v_access_controls
    ADD CONSTRAINT v_access_controls_pkey PRIMARY KEY (access_control_uuid);
 R   ALTER TABLE ONLY public.v_access_controls DROP CONSTRAINT v_access_controls_pkey;
       public         	   fusionpbx    false    218            H           2606    2163993 "   v_applications v_applications_pkey 
   CONSTRAINT     n   ALTER TABLE ONLY public.v_applications
    ADD CONSTRAINT v_applications_pkey PRIMARY KEY (application_uuid);
 L   ALTER TABLE ONLY public.v_applications DROP CONSTRAINT v_applications_pkey;
       public         	   fusionpbx    false    219            J           2606    2163995    v_bridges v_bridges_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY public.v_bridges
    ADD CONSTRAINT v_bridges_pkey PRIMARY KEY (bridge_uuid);
 B   ALTER TABLE ONLY public.v_bridges DROP CONSTRAINT v_bridges_pkey;
       public         	   fusionpbx    false    220            L           2606    2163997    v_call_block v_call_block_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY public.v_call_block
    ADD CONSTRAINT v_call_block_pkey PRIMARY KEY (call_block_uuid);
 H   ALTER TABLE ONLY public.v_call_block DROP CONSTRAINT v_call_block_pkey;
       public         	   fusionpbx    false    221            N           2606    2163999 (   v_call_broadcasts v_call_broadcasts_pkey 
   CONSTRAINT     w   ALTER TABLE ONLY public.v_call_broadcasts
    ADD CONSTRAINT v_call_broadcasts_pkey PRIMARY KEY (call_broadcast_uuid);
 R   ALTER TABLE ONLY public.v_call_broadcasts DROP CONSTRAINT v_call_broadcasts_pkey;
       public         	   fusionpbx    false    222            P           2606    2164001 .   v_call_center_agents v_call_center_agents_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.v_call_center_agents
    ADD CONSTRAINT v_call_center_agents_pkey PRIMARY KEY (call_center_agent_uuid);
 X   ALTER TABLE ONLY public.v_call_center_agents DROP CONSTRAINT v_call_center_agents_pkey;
       public         	   fusionpbx    false    223            R           2606    2164003 .   v_call_center_queues v_call_center_queues_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.v_call_center_queues
    ADD CONSTRAINT v_call_center_queues_pkey PRIMARY KEY (call_center_queue_uuid);
 X   ALTER TABLE ONLY public.v_call_center_queues DROP CONSTRAINT v_call_center_queues_pkey;
       public         	   fusionpbx    false    224            T           2606    2164005 ,   v_call_center_tiers v_call_center_tiers_pkey 
   CONSTRAINT     }   ALTER TABLE ONLY public.v_call_center_tiers
    ADD CONSTRAINT v_call_center_tiers_pkey PRIMARY KEY (call_center_tier_uuid);
 V   ALTER TABLE ONLY public.v_call_center_tiers DROP CONSTRAINT v_call_center_tiers_pkey;
       public         	   fusionpbx    false    225            V           2606    2164007    v_call_flows v_call_flows_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.v_call_flows
    ADD CONSTRAINT v_call_flows_pkey PRIMARY KEY (call_flow_uuid);
 H   ALTER TABLE ONLY public.v_call_flows DROP CONSTRAINT v_call_flows_pkey;
       public         	   fusionpbx    false    226            X           2606    2164009 .   v_conference_centers v_conference_centers_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.v_conference_centers
    ADD CONSTRAINT v_conference_centers_pkey PRIMARY KEY (conference_center_uuid);
 X   ALTER TABLE ONLY public.v_conference_centers DROP CONSTRAINT v_conference_centers_pkey;
       public         	   fusionpbx    false    227            Z           2606    2164011 >   v_conference_control_details v_conference_control_details_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.v_conference_control_details
    ADD CONSTRAINT v_conference_control_details_pkey PRIMARY KEY (conference_control_detail_uuid);
 h   ALTER TABLE ONLY public.v_conference_control_details DROP CONSTRAINT v_conference_control_details_pkey;
       public         	   fusionpbx    false    228            \           2606    2164013 0   v_conference_controls v_conference_controls_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.v_conference_controls
    ADD CONSTRAINT v_conference_controls_pkey PRIMARY KEY (conference_control_uuid);
 Z   ALTER TABLE ONLY public.v_conference_controls DROP CONSTRAINT v_conference_controls_pkey;
       public         	   fusionpbx    false    229            ^           2606    2164015 <   v_conference_profile_params v_conference_profile_params_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.v_conference_profile_params
    ADD CONSTRAINT v_conference_profile_params_pkey PRIMARY KEY (conference_profile_param_uuid);
 f   ALTER TABLE ONLY public.v_conference_profile_params DROP CONSTRAINT v_conference_profile_params_pkey;
       public         	   fusionpbx    false    230            `           2606    2164017 0   v_conference_profiles v_conference_profiles_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.v_conference_profiles
    ADD CONSTRAINT v_conference_profiles_pkey PRIMARY KEY (conference_profile_uuid);
 Z   ALTER TABLE ONLY public.v_conference_profiles DROP CONSTRAINT v_conference_profiles_pkey;
       public         	   fusionpbx    false    231            b           2606    2164019 4   v_conference_room_users v_conference_room_users_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.v_conference_room_users
    ADD CONSTRAINT v_conference_room_users_pkey PRIMARY KEY (conference_room_user_uuid);
 ^   ALTER TABLE ONLY public.v_conference_room_users DROP CONSTRAINT v_conference_room_users_pkey;
       public         	   fusionpbx    false    232            d           2606    2164021 *   v_conference_rooms v_conference_rooms_pkey 
   CONSTRAINT     z   ALTER TABLE ONLY public.v_conference_rooms
    ADD CONSTRAINT v_conference_rooms_pkey PRIMARY KEY (conference_room_uuid);
 T   ALTER TABLE ONLY public.v_conference_rooms DROP CONSTRAINT v_conference_rooms_pkey;
       public         	   fusionpbx    false    233            f           2606    2164023 >   v_conference_session_details v_conference_session_details_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.v_conference_session_details
    ADD CONSTRAINT v_conference_session_details_pkey PRIMARY KEY (conference_session_detail_uuid);
 h   ALTER TABLE ONLY public.v_conference_session_details DROP CONSTRAINT v_conference_session_details_pkey;
       public         	   fusionpbx    false    234            h           2606    2164025 0   v_conference_sessions v_conference_sessions_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.v_conference_sessions
    ADD CONSTRAINT v_conference_sessions_pkey PRIMARY KEY (conference_session_uuid);
 Z   ALTER TABLE ONLY public.v_conference_sessions DROP CONSTRAINT v_conference_sessions_pkey;
       public         	   fusionpbx    false    235            j           2606    2164027 *   v_conference_users v_conference_users_pkey 
   CONSTRAINT     z   ALTER TABLE ONLY public.v_conference_users
    ADD CONSTRAINT v_conference_users_pkey PRIMARY KEY (conference_user_uuid);
 T   ALTER TABLE ONLY public.v_conference_users DROP CONSTRAINT v_conference_users_pkey;
       public         	   fusionpbx    false    236            l           2606    2164029     v_conferences v_conferences_pkey 
   CONSTRAINT     k   ALTER TABLE ONLY public.v_conferences
    ADD CONSTRAINT v_conferences_pkey PRIMARY KEY (conference_uuid);
 J   ALTER TABLE ONLY public.v_conferences DROP CONSTRAINT v_conferences_pkey;
       public         	   fusionpbx    false    237            n           2606    2164031 ,   v_contact_addresses v_contact_addresses_pkey 
   CONSTRAINT     |   ALTER TABLE ONLY public.v_contact_addresses
    ADD CONSTRAINT v_contact_addresses_pkey PRIMARY KEY (contact_address_uuid);
 V   ALTER TABLE ONLY public.v_contact_addresses DROP CONSTRAINT v_contact_addresses_pkey;
       public         	   fusionpbx    false    238            p           2606    2164033 0   v_contact_attachments v_contact_attachments_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.v_contact_attachments
    ADD CONSTRAINT v_contact_attachments_pkey PRIMARY KEY (contact_attachment_uuid);
 Z   ALTER TABLE ONLY public.v_contact_attachments DROP CONSTRAINT v_contact_attachments_pkey;
       public         	   fusionpbx    false    239            r           2606    2164035 &   v_contact_emails v_contact_emails_pkey 
   CONSTRAINT     t   ALTER TABLE ONLY public.v_contact_emails
    ADD CONSTRAINT v_contact_emails_pkey PRIMARY KEY (contact_email_uuid);
 P   ALTER TABLE ONLY public.v_contact_emails DROP CONSTRAINT v_contact_emails_pkey;
       public         	   fusionpbx    false    240            t           2606    2164037 &   v_contact_groups v_contact_groups_pkey 
   CONSTRAINT     t   ALTER TABLE ONLY public.v_contact_groups
    ADD CONSTRAINT v_contact_groups_pkey PRIMARY KEY (contact_group_uuid);
 P   ALTER TABLE ONLY public.v_contact_groups DROP CONSTRAINT v_contact_groups_pkey;
       public         	   fusionpbx    false    241            v           2606    2164039 $   v_contact_notes v_contact_notes_pkey 
   CONSTRAINT     q   ALTER TABLE ONLY public.v_contact_notes
    ADD CONSTRAINT v_contact_notes_pkey PRIMARY KEY (contact_note_uuid);
 N   ALTER TABLE ONLY public.v_contact_notes DROP CONSTRAINT v_contact_notes_pkey;
       public         	   fusionpbx    false    242            x           2606    2164041 &   v_contact_phones v_contact_phones_pkey 
   CONSTRAINT     t   ALTER TABLE ONLY public.v_contact_phones
    ADD CONSTRAINT v_contact_phones_pkey PRIMARY KEY (contact_phone_uuid);
 P   ALTER TABLE ONLY public.v_contact_phones DROP CONSTRAINT v_contact_phones_pkey;
       public         	   fusionpbx    false    243            z           2606    2164043 ,   v_contact_relations v_contact_relations_pkey 
   CONSTRAINT     }   ALTER TABLE ONLY public.v_contact_relations
    ADD CONSTRAINT v_contact_relations_pkey PRIMARY KEY (contact_relation_uuid);
 V   ALTER TABLE ONLY public.v_contact_relations DROP CONSTRAINT v_contact_relations_pkey;
       public         	   fusionpbx    false    244            |           2606    2164045 *   v_contact_settings v_contact_settings_pkey 
   CONSTRAINT     z   ALTER TABLE ONLY public.v_contact_settings
    ADD CONSTRAINT v_contact_settings_pkey PRIMARY KEY (contact_setting_uuid);
 T   ALTER TABLE ONLY public.v_contact_settings DROP CONSTRAINT v_contact_settings_pkey;
       public         	   fusionpbx    false    245            ~           2606    2164047 $   v_contact_times v_contact_times_pkey 
   CONSTRAINT     q   ALTER TABLE ONLY public.v_contact_times
    ADD CONSTRAINT v_contact_times_pkey PRIMARY KEY (contact_time_uuid);
 N   ALTER TABLE ONLY public.v_contact_times DROP CONSTRAINT v_contact_times_pkey;
       public         	   fusionpbx    false    246            �           2606    2164049 "   v_contact_urls v_contact_urls_pkey 
   CONSTRAINT     n   ALTER TABLE ONLY public.v_contact_urls
    ADD CONSTRAINT v_contact_urls_pkey PRIMARY KEY (contact_url_uuid);
 L   ALTER TABLE ONLY public.v_contact_urls DROP CONSTRAINT v_contact_urls_pkey;
       public         	   fusionpbx    false    247            �           2606    2164051 $   v_contact_users v_contact_users_pkey 
   CONSTRAINT     q   ALTER TABLE ONLY public.v_contact_users
    ADD CONSTRAINT v_contact_users_pkey PRIMARY KEY (contact_user_uuid);
 N   ALTER TABLE ONLY public.v_contact_users DROP CONSTRAINT v_contact_users_pkey;
       public         	   fusionpbx    false    248            �           2606    2164053    v_contacts v_contacts_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.v_contacts
    ADD CONSTRAINT v_contacts_pkey PRIMARY KEY (contact_uuid);
 D   ALTER TABLE ONLY public.v_contacts DROP CONSTRAINT v_contacts_pkey;
       public         	   fusionpbx    false    249            �           2606    2164055    v_countries v_countries_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.v_countries
    ADD CONSTRAINT v_countries_pkey PRIMARY KEY (country_uuid);
 F   ALTER TABLE ONLY public.v_countries DROP CONSTRAINT v_countries_pkey;
       public         	   fusionpbx    false    250            �           2606    2164057 *   v_dashboard_groups v_dashboard_groups_pkey 
   CONSTRAINT     z   ALTER TABLE ONLY public.v_dashboard_groups
    ADD CONSTRAINT v_dashboard_groups_pkey PRIMARY KEY (dashboard_group_uuid);
 T   ALTER TABLE ONLY public.v_dashboard_groups DROP CONSTRAINT v_dashboard_groups_pkey;
       public         	   fusionpbx    false    252            �           2606    2164059    v_dashboard v_dashboard_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.v_dashboard
    ADD CONSTRAINT v_dashboard_pkey PRIMARY KEY (dashboard_uuid);
 F   ALTER TABLE ONLY public.v_dashboard DROP CONSTRAINT v_dashboard_pkey;
       public         	   fusionpbx    false    251            �           2606    2164061 4   v_database_transactions v_database_transactions_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.v_database_transactions
    ADD CONSTRAINT v_database_transactions_pkey PRIMARY KEY (database_transaction_uuid);
 ^   ALTER TABLE ONLY public.v_database_transactions DROP CONSTRAINT v_database_transactions_pkey;
       public         	   fusionpbx    false    253            �           2606    2164063    v_databases v_databases_pkey 
   CONSTRAINT     e   ALTER TABLE ONLY public.v_databases
    ADD CONSTRAINT v_databases_pkey PRIMARY KEY (database_uuid);
 F   ALTER TABLE ONLY public.v_databases DROP CONSTRAINT v_databases_pkey;
       public         	   fusionpbx    false    254            �           2606    2164065 *   v_default_settings v_default_settings_pkey 
   CONSTRAINT     z   ALTER TABLE ONLY public.v_default_settings
    ADD CONSTRAINT v_default_settings_pkey PRIMARY KEY (default_setting_uuid);
 T   ALTER TABLE ONLY public.v_default_settings DROP CONSTRAINT v_default_settings_pkey;
       public         	   fusionpbx    false    255            �           2606    2164067 "   v_destinations v_destinations_pkey 
   CONSTRAINT     n   ALTER TABLE ONLY public.v_destinations
    ADD CONSTRAINT v_destinations_pkey PRIMARY KEY (destination_uuid);
 L   ALTER TABLE ONLY public.v_destinations DROP CONSTRAINT v_destinations_pkey;
       public         	   fusionpbx    false    256            �           2606    2164069     v_device_keys v_device_keys_pkey 
   CONSTRAINT     k   ALTER TABLE ONLY public.v_device_keys
    ADD CONSTRAINT v_device_keys_pkey PRIMARY KEY (device_key_uuid);
 J   ALTER TABLE ONLY public.v_device_keys DROP CONSTRAINT v_device_keys_pkey;
       public         	   fusionpbx    false    257            �           2606    2164071 "   v_device_lines v_device_lines_pkey 
   CONSTRAINT     n   ALTER TABLE ONLY public.v_device_lines
    ADD CONSTRAINT v_device_lines_pkey PRIMARY KEY (device_line_uuid);
 L   ALTER TABLE ONLY public.v_device_lines DROP CONSTRAINT v_device_lines_pkey;
       public         	   fusionpbx    false    258            �           2606    2164073 0   v_device_profile_keys v_device_profile_keys_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.v_device_profile_keys
    ADD CONSTRAINT v_device_profile_keys_pkey PRIMARY KEY (device_profile_key_uuid);
 Z   ALTER TABLE ONLY public.v_device_profile_keys DROP CONSTRAINT v_device_profile_keys_pkey;
       public         	   fusionpbx    false    259            �           2606    2164075 8   v_device_profile_settings v_device_profile_settings_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.v_device_profile_settings
    ADD CONSTRAINT v_device_profile_settings_pkey PRIMARY KEY (device_profile_setting_uuid);
 b   ALTER TABLE ONLY public.v_device_profile_settings DROP CONSTRAINT v_device_profile_settings_pkey;
       public         	   fusionpbx    false    260            �           2606    2164077 (   v_device_profiles v_device_profiles_pkey 
   CONSTRAINT     w   ALTER TABLE ONLY public.v_device_profiles
    ADD CONSTRAINT v_device_profiles_pkey PRIMARY KEY (device_profile_uuid);
 R   ALTER TABLE ONLY public.v_device_profiles DROP CONSTRAINT v_device_profiles_pkey;
       public         	   fusionpbx    false    261            �           2606    2164079 (   v_device_settings v_device_settings_pkey 
   CONSTRAINT     w   ALTER TABLE ONLY public.v_device_settings
    ADD CONSTRAINT v_device_settings_pkey PRIMARY KEY (device_setting_uuid);
 R   ALTER TABLE ONLY public.v_device_settings DROP CONSTRAINT v_device_settings_pkey;
       public         	   fusionpbx    false    262            �           2606    2164081 D   v_device_vendor_function_groups v_device_vendor_function_groups_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.v_device_vendor_function_groups
    ADD CONSTRAINT v_device_vendor_function_groups_pkey PRIMARY KEY (device_vendor_function_group_uuid);
 n   ALTER TABLE ONLY public.v_device_vendor_function_groups DROP CONSTRAINT v_device_vendor_function_groups_pkey;
       public         	   fusionpbx    false    263            �           2606    2164083 8   v_device_vendor_functions v_device_vendor_functions_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.v_device_vendor_functions
    ADD CONSTRAINT v_device_vendor_functions_pkey PRIMARY KEY (device_vendor_function_uuid);
 b   ALTER TABLE ONLY public.v_device_vendor_functions DROP CONSTRAINT v_device_vendor_functions_pkey;
       public         	   fusionpbx    false    264            �           2606    2164085 &   v_device_vendors v_device_vendors_pkey 
   CONSTRAINT     t   ALTER TABLE ONLY public.v_device_vendors
    ADD CONSTRAINT v_device_vendors_pkey PRIMARY KEY (device_vendor_uuid);
 P   ALTER TABLE ONLY public.v_device_vendors DROP CONSTRAINT v_device_vendors_pkey;
       public         	   fusionpbx    false    265            �           2606    2164087    v_devices v_devices_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY public.v_devices
    ADD CONSTRAINT v_devices_pkey PRIMARY KEY (device_uuid);
 B   ALTER TABLE ONLY public.v_devices DROP CONSTRAINT v_devices_pkey;
       public         	   fusionpbx    false    266            �           2606    2164089 *   v_dialplan_details v_dialplan_details_pkey 
   CONSTRAINT     z   ALTER TABLE ONLY public.v_dialplan_details
    ADD CONSTRAINT v_dialplan_details_pkey PRIMARY KEY (dialplan_detail_uuid);
 T   ALTER TABLE ONLY public.v_dialplan_details DROP CONSTRAINT v_dialplan_details_pkey;
       public         	   fusionpbx    false    267            �           2606    2164091    v_dialplans v_dialplans_pkey 
   CONSTRAINT     e   ALTER TABLE ONLY public.v_dialplans
    ADD CONSTRAINT v_dialplans_pkey PRIMARY KEY (dialplan_uuid);
 F   ALTER TABLE ONLY public.v_dialplans DROP CONSTRAINT v_dialplans_pkey;
       public         	   fusionpbx    false    268            �           2606    2164093 (   v_domain_settings v_domain_settings_pkey 
   CONSTRAINT     w   ALTER TABLE ONLY public.v_domain_settings
    ADD CONSTRAINT v_domain_settings_pkey PRIMARY KEY (domain_setting_uuid);
 R   ALTER TABLE ONLY public.v_domain_settings DROP CONSTRAINT v_domain_settings_pkey;
       public         	   fusionpbx    false    269            �           2606    2164095    v_domains v_domains_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY public.v_domains
    ADD CONSTRAINT v_domains_pkey PRIMARY KEY (domain_uuid);
 B   ALTER TABLE ONLY public.v_domains DROP CONSTRAINT v_domains_pkey;
       public         	   fusionpbx    false    270            �           2606    2164097    v_email_logs v_email_logs_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.v_email_logs
    ADD CONSTRAINT v_email_logs_pkey PRIMARY KEY (email_log_uuid);
 H   ALTER TABLE ONLY public.v_email_logs DROP CONSTRAINT v_email_logs_pkey;
       public         	   fusionpbx    false    271            �           2606    2164099 8   v_email_queue_attachments v_email_queue_attachments_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.v_email_queue_attachments
    ADD CONSTRAINT v_email_queue_attachments_pkey PRIMARY KEY (email_queue_attachment_uuid);
 b   ALTER TABLE ONLY public.v_email_queue_attachments DROP CONSTRAINT v_email_queue_attachments_pkey;
       public         	   fusionpbx    false    273            �           2606    2164101     v_email_queue v_email_queue_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.v_email_queue
    ADD CONSTRAINT v_email_queue_pkey PRIMARY KEY (email_queue_uuid);
 J   ALTER TABLE ONLY public.v_email_queue DROP CONSTRAINT v_email_queue_pkey;
       public         	   fusionpbx    false    272            �           2606    2164103 (   v_email_templates v_email_templates_pkey 
   CONSTRAINT     w   ALTER TABLE ONLY public.v_email_templates
    ADD CONSTRAINT v_email_templates_pkey PRIMARY KEY (email_template_uuid);
 R   ALTER TABLE ONLY public.v_email_templates DROP CONSTRAINT v_email_templates_pkey;
       public         	   fusionpbx    false    274            �           2606    2164105 *   v_event_guard_logs v_event_guard_logs_pkey 
   CONSTRAINT     z   ALTER TABLE ONLY public.v_event_guard_logs
    ADD CONSTRAINT v_event_guard_logs_pkey PRIMARY KEY (event_guard_log_uuid);
 T   ALTER TABLE ONLY public.v_event_guard_logs DROP CONSTRAINT v_event_guard_logs_pkey;
       public         	   fusionpbx    false    275            �           2606    2164107 .   v_extension_settings v_extension_settings_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.v_extension_settings
    ADD CONSTRAINT v_extension_settings_pkey PRIMARY KEY (extension_setting_uuid);
 X   ALTER TABLE ONLY public.v_extension_settings DROP CONSTRAINT v_extension_settings_pkey;
       public         	   fusionpbx    false    276            �           2606    2164109 (   v_extension_users v_extension_users_pkey 
   CONSTRAINT     w   ALTER TABLE ONLY public.v_extension_users
    ADD CONSTRAINT v_extension_users_pkey PRIMARY KEY (extension_user_uuid);
 R   ALTER TABLE ONLY public.v_extension_users DROP CONSTRAINT v_extension_users_pkey;
       public         	   fusionpbx    false    277            �           2606    2164111    v_extensions v_extensions_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.v_extensions
    ADD CONSTRAINT v_extensions_pkey PRIMARY KEY (extension_uuid);
 H   ALTER TABLE ONLY public.v_extensions DROP CONSTRAINT v_extensions_pkey;
       public         	   fusionpbx    false    278            �           2606    2164113    v_fax_files v_fax_files_pkey 
   CONSTRAINT     e   ALTER TABLE ONLY public.v_fax_files
    ADD CONSTRAINT v_fax_files_pkey PRIMARY KEY (fax_file_uuid);
 F   ALTER TABLE ONLY public.v_fax_files DROP CONSTRAINT v_fax_files_pkey;
       public         	   fusionpbx    false    280            �           2606    2164115    v_fax_logs v_fax_logs_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.v_fax_logs
    ADD CONSTRAINT v_fax_logs_pkey PRIMARY KEY (fax_log_uuid);
 D   ALTER TABLE ONLY public.v_fax_logs DROP CONSTRAINT v_fax_logs_pkey;
       public         	   fusionpbx    false    281            �           2606    2164117    v_fax v_fax_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.v_fax
    ADD CONSTRAINT v_fax_pkey PRIMARY KEY (fax_uuid);
 :   ALTER TABLE ONLY public.v_fax DROP CONSTRAINT v_fax_pkey;
       public         	   fusionpbx    false    279            �           2606    2164119    v_fax_queue v_fax_queue_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.v_fax_queue
    ADD CONSTRAINT v_fax_queue_pkey PRIMARY KEY (fax_queue_uuid);
 F   ALTER TABLE ONLY public.v_fax_queue DROP CONSTRAINT v_fax_queue_pkey;
       public         	   fusionpbx    false    282            �           2606    2164121    v_fax_tasks v_fax_tasks_pkey 
   CONSTRAINT     e   ALTER TABLE ONLY public.v_fax_tasks
    ADD CONSTRAINT v_fax_tasks_pkey PRIMARY KEY (fax_task_uuid);
 F   ALTER TABLE ONLY public.v_fax_tasks DROP CONSTRAINT v_fax_tasks_pkey;
       public         	   fusionpbx    false    283            �           2606    2164123    v_fax_users v_fax_users_pkey 
   CONSTRAINT     e   ALTER TABLE ONLY public.v_fax_users
    ADD CONSTRAINT v_fax_users_pkey PRIMARY KEY (fax_user_uuid);
 F   ALTER TABLE ONLY public.v_fax_users DROP CONSTRAINT v_fax_users_pkey;
       public         	   fusionpbx    false    284            �           2606    2164125 6   v_follow_me_destinations v_follow_me_destinations_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.v_follow_me_destinations
    ADD CONSTRAINT v_follow_me_destinations_pkey PRIMARY KEY (follow_me_destination_uuid);
 `   ALTER TABLE ONLY public.v_follow_me_destinations DROP CONSTRAINT v_follow_me_destinations_pkey;
       public         	   fusionpbx    false    286            �           2606    2164127    v_follow_me v_follow_me_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.v_follow_me
    ADD CONSTRAINT v_follow_me_pkey PRIMARY KEY (follow_me_uuid);
 F   ALTER TABLE ONLY public.v_follow_me DROP CONSTRAINT v_follow_me_pkey;
       public         	   fusionpbx    false    285            �           2606    2164129    v_gateways v_gateways_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.v_gateways
    ADD CONSTRAINT v_gateways_pkey PRIMARY KEY (gateway_uuid);
 D   ALTER TABLE ONLY public.v_gateways DROP CONSTRAINT v_gateways_pkey;
       public         	   fusionpbx    false    287            �           2606    2164131 ,   v_group_permissions v_group_permissions_pkey 
   CONSTRAINT     }   ALTER TABLE ONLY public.v_group_permissions
    ADD CONSTRAINT v_group_permissions_pkey PRIMARY KEY (group_permission_uuid);
 V   ALTER TABLE ONLY public.v_group_permissions DROP CONSTRAINT v_group_permissions_pkey;
       public         	   fusionpbx    false    288            �           2606    2164133    v_groups v_groups_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.v_groups
    ADD CONSTRAINT v_groups_pkey PRIMARY KEY (group_uuid);
 @   ALTER TABLE ONLY public.v_groups DROP CONSTRAINT v_groups_pkey;
       public         	   fusionpbx    false    289            �           2606    2164135 *   v_ivr_menu_options v_ivr_menu_options_pkey 
   CONSTRAINT     z   ALTER TABLE ONLY public.v_ivr_menu_options
    ADD CONSTRAINT v_ivr_menu_options_pkey PRIMARY KEY (ivr_menu_option_uuid);
 T   ALTER TABLE ONLY public.v_ivr_menu_options DROP CONSTRAINT v_ivr_menu_options_pkey;
       public         	   fusionpbx    false    290            �           2606    2164137    v_ivr_menus v_ivr_menus_pkey 
   CONSTRAINT     e   ALTER TABLE ONLY public.v_ivr_menus
    ADD CONSTRAINT v_ivr_menus_pkey PRIMARY KEY (ivr_menu_uuid);
 F   ALTER TABLE ONLY public.v_ivr_menus DROP CONSTRAINT v_ivr_menus_pkey;
       public         	   fusionpbx    false    291            �           2606    2164139    v_languages v_languages_pkey 
   CONSTRAINT     e   ALTER TABLE ONLY public.v_languages
    ADD CONSTRAINT v_languages_pkey PRIMARY KEY (language_uuid);
 F   ALTER TABLE ONLY public.v_languages DROP CONSTRAINT v_languages_pkey;
       public         	   fusionpbx    false    292            �           2606    2164141 *   v_menu_item_groups v_menu_item_groups_pkey 
   CONSTRAINT     z   ALTER TABLE ONLY public.v_menu_item_groups
    ADD CONSTRAINT v_menu_item_groups_pkey PRIMARY KEY (menu_item_group_uuid);
 T   ALTER TABLE ONLY public.v_menu_item_groups DROP CONSTRAINT v_menu_item_groups_pkey;
       public         	   fusionpbx    false    293            �           2606    2164143    v_menu_items v_menu_items_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.v_menu_items
    ADD CONSTRAINT v_menu_items_pkey PRIMARY KEY (menu_item_uuid);
 H   ALTER TABLE ONLY public.v_menu_items DROP CONSTRAINT v_menu_items_pkey;
       public         	   fusionpbx    false    294            �           2606    2164145 &   v_menu_languages v_menu_languages_pkey 
   CONSTRAINT     t   ALTER TABLE ONLY public.v_menu_languages
    ADD CONSTRAINT v_menu_languages_pkey PRIMARY KEY (menu_language_uuid);
 P   ALTER TABLE ONLY public.v_menu_languages DROP CONSTRAINT v_menu_languages_pkey;
       public         	   fusionpbx    false    295            �           2606    2164147    v_menus v_menus_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.v_menus
    ADD CONSTRAINT v_menus_pkey PRIMARY KEY (menu_uuid);
 >   ALTER TABLE ONLY public.v_menus DROP CONSTRAINT v_menus_pkey;
       public         	   fusionpbx    false    296            �           2606    2164149    v_modules v_modules_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY public.v_modules
    ADD CONSTRAINT v_modules_pkey PRIMARY KEY (module_uuid);
 B   ALTER TABLE ONLY public.v_modules DROP CONSTRAINT v_modules_pkey;
       public         	   fusionpbx    false    297            �           2606    2164151 $   v_music_on_hold v_music_on_hold_pkey 
   CONSTRAINT     r   ALTER TABLE ONLY public.v_music_on_hold
    ADD CONSTRAINT v_music_on_hold_pkey PRIMARY KEY (music_on_hold_uuid);
 N   ALTER TABLE ONLY public.v_music_on_hold DROP CONSTRAINT v_music_on_hold_pkey;
       public         	   fusionpbx    false    298            �           2606    2164153 $   v_notifications v_notifications_pkey 
   CONSTRAINT     q   ALTER TABLE ONLY public.v_notifications
    ADD CONSTRAINT v_notifications_pkey PRIMARY KEY (notification_uuid);
 N   ALTER TABLE ONLY public.v_notifications DROP CONSTRAINT v_notifications_pkey;
       public         	   fusionpbx    false    299            �           2606    2164155 >   v_number_translation_details v_number_translation_details_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.v_number_translation_details
    ADD CONSTRAINT v_number_translation_details_pkey PRIMARY KEY (number_translation_detail_uuid);
 h   ALTER TABLE ONLY public.v_number_translation_details DROP CONSTRAINT v_number_translation_details_pkey;
       public         	   fusionpbx    false    300            �           2606    2164157 0   v_number_translations v_number_translations_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.v_number_translations
    ADD CONSTRAINT v_number_translations_pkey PRIMARY KEY (number_translation_uuid);
 Z   ALTER TABLE ONLY public.v_number_translations DROP CONSTRAINT v_number_translations_pkey;
       public         	   fusionpbx    false    301            �           2606    2164159     v_permissions v_permissions_pkey 
   CONSTRAINT     k   ALTER TABLE ONLY public.v_permissions
    ADD CONSTRAINT v_permissions_pkey PRIMARY KEY (permission_uuid);
 J   ALTER TABLE ONLY public.v_permissions DROP CONSTRAINT v_permissions_pkey;
       public         	   fusionpbx    false    302            �           2606    2164161 &   v_phrase_details v_phrase_details_pkey 
   CONSTRAINT     t   ALTER TABLE ONLY public.v_phrase_details
    ADD CONSTRAINT v_phrase_details_pkey PRIMARY KEY (phrase_detail_uuid);
 P   ALTER TABLE ONLY public.v_phrase_details DROP CONSTRAINT v_phrase_details_pkey;
       public         	   fusionpbx    false    303            �           2606    2164163    v_phrases v_phrases_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY public.v_phrases
    ADD CONSTRAINT v_phrases_pkey PRIMARY KEY (phrase_uuid);
 B   ALTER TABLE ONLY public.v_phrases DROP CONSTRAINT v_phrases_pkey;
       public         	   fusionpbx    false    304            �           2606    2164165     v_pin_numbers v_pin_numbers_pkey 
   CONSTRAINT     k   ALTER TABLE ONLY public.v_pin_numbers
    ADD CONSTRAINT v_pin_numbers_pkey PRIMARY KEY (pin_number_uuid);
 J   ALTER TABLE ONLY public.v_pin_numbers DROP CONSTRAINT v_pin_numbers_pkey;
       public         	   fusionpbx    false    305            �           2606    2164167    v_recordings v_recordings_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.v_recordings
    ADD CONSTRAINT v_recordings_pkey PRIMARY KEY (recording_uuid);
 H   ALTER TABLE ONLY public.v_recordings DROP CONSTRAINT v_recordings_pkey;
       public         	   fusionpbx    false    306            �           2606    2164169 8   v_ring_group_destinations v_ring_group_destinations_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.v_ring_group_destinations
    ADD CONSTRAINT v_ring_group_destinations_pkey PRIMARY KEY (ring_group_destination_uuid);
 b   ALTER TABLE ONLY public.v_ring_group_destinations DROP CONSTRAINT v_ring_group_destinations_pkey;
       public         	   fusionpbx    false    307            �           2606    2164171 *   v_ring_group_users v_ring_group_users_pkey 
   CONSTRAINT     z   ALTER TABLE ONLY public.v_ring_group_users
    ADD CONSTRAINT v_ring_group_users_pkey PRIMARY KEY (ring_group_user_uuid);
 T   ALTER TABLE ONLY public.v_ring_group_users DROP CONSTRAINT v_ring_group_users_pkey;
       public         	   fusionpbx    false    308            �           2606    2164173     v_ring_groups v_ring_groups_pkey 
   CONSTRAINT     k   ALTER TABLE ONLY public.v_ring_groups
    ADD CONSTRAINT v_ring_groups_pkey PRIMARY KEY (ring_group_uuid);
 J   ALTER TABLE ONLY public.v_ring_groups DROP CONSTRAINT v_ring_groups_pkey;
       public         	   fusionpbx    false    309            �           2606    2164175    v_settings v_settings_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.v_settings
    ADD CONSTRAINT v_settings_pkey PRIMARY KEY (setting_uuid);
 D   ALTER TABLE ONLY public.v_settings DROP CONSTRAINT v_settings_pkey;
       public         	   fusionpbx    false    310                        2606    2164177 0   v_sip_profile_domains v_sip_profile_domains_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.v_sip_profile_domains
    ADD CONSTRAINT v_sip_profile_domains_pkey PRIMARY KEY (sip_profile_domain_uuid);
 Z   ALTER TABLE ONLY public.v_sip_profile_domains DROP CONSTRAINT v_sip_profile_domains_pkey;
       public         	   fusionpbx    false    311                       2606    2164179 2   v_sip_profile_settings v_sip_profile_settings_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.v_sip_profile_settings
    ADD CONSTRAINT v_sip_profile_settings_pkey PRIMARY KEY (sip_profile_setting_uuid);
 \   ALTER TABLE ONLY public.v_sip_profile_settings DROP CONSTRAINT v_sip_profile_settings_pkey;
       public         	   fusionpbx    false    312                       2606    2164181 "   v_sip_profiles v_sip_profiles_pkey 
   CONSTRAINT     n   ALTER TABLE ONLY public.v_sip_profiles
    ADD CONSTRAINT v_sip_profiles_pkey PRIMARY KEY (sip_profile_uuid);
 L   ALTER TABLE ONLY public.v_sip_profiles DROP CONSTRAINT v_sip_profiles_pkey;
       public         	   fusionpbx    false    313                       2606    2164183 4   v_sofia_global_settings v_sofia_global_settings_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.v_sofia_global_settings
    ADD CONSTRAINT v_sofia_global_settings_pkey PRIMARY KEY (sofia_global_setting_uuid);
 ^   ALTER TABLE ONLY public.v_sofia_global_settings DROP CONSTRAINT v_sofia_global_settings_pkey;
       public         	   fusionpbx    false    314                       2606    2164185    v_software v_software_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public.v_software
    ADD CONSTRAINT v_software_pkey PRIMARY KEY (software_uuid);
 D   ALTER TABLE ONLY public.v_software DROP CONSTRAINT v_software_pkey;
       public         	   fusionpbx    false    315            
           2606    2164187    v_streams v_streams_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY public.v_streams
    ADD CONSTRAINT v_streams_pkey PRIMARY KEY (stream_uuid);
 B   ALTER TABLE ONLY public.v_streams DROP CONSTRAINT v_streams_pkey;
       public         	   fusionpbx    false    316                       2606    2164189     v_user_groups v_user_groups_pkey 
   CONSTRAINT     k   ALTER TABLE ONLY public.v_user_groups
    ADD CONSTRAINT v_user_groups_pkey PRIMARY KEY (user_group_uuid);
 J   ALTER TABLE ONLY public.v_user_groups DROP CONSTRAINT v_user_groups_pkey;
       public         	   fusionpbx    false    317                       2606    2164191    v_user_logs v_user_logs_pkey 
   CONSTRAINT     e   ALTER TABLE ONLY public.v_user_logs
    ADD CONSTRAINT v_user_logs_pkey PRIMARY KEY (user_log_uuid);
 F   ALTER TABLE ONLY public.v_user_logs DROP CONSTRAINT v_user_logs_pkey;
       public         	   fusionpbx    false    318                       2606    2164193 $   v_user_settings v_user_settings_pkey 
   CONSTRAINT     q   ALTER TABLE ONLY public.v_user_settings
    ADD CONSTRAINT v_user_settings_pkey PRIMARY KEY (user_setting_uuid);
 N   ALTER TABLE ONLY public.v_user_settings DROP CONSTRAINT v_user_settings_pkey;
       public         	   fusionpbx    false    319                       2606    2164195    v_users v_users_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.v_users
    ADD CONSTRAINT v_users_pkey PRIMARY KEY (user_uuid);
 >   ALTER TABLE ONLY public.v_users DROP CONSTRAINT v_users_pkey;
       public         	   fusionpbx    false    320                       2606    2164197    v_vars v_vars_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.v_vars
    ADD CONSTRAINT v_vars_pkey PRIMARY KEY (var_uuid);
 <   ALTER TABLE ONLY public.v_vars DROP CONSTRAINT v_vars_pkey;
       public         	   fusionpbx    false    321                       2606    2164199 6   v_voicemail_destinations v_voicemail_destinations_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.v_voicemail_destinations
    ADD CONSTRAINT v_voicemail_destinations_pkey PRIMARY KEY (voicemail_destination_uuid);
 `   ALTER TABLE ONLY public.v_voicemail_destinations DROP CONSTRAINT v_voicemail_destinations_pkey;
       public         	   fusionpbx    false    322                       2606    2164201 0   v_voicemail_greetings v_voicemail_greetings_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.v_voicemail_greetings
    ADD CONSTRAINT v_voicemail_greetings_pkey PRIMARY KEY (voicemail_greeting_uuid);
 Z   ALTER TABLE ONLY public.v_voicemail_greetings DROP CONSTRAINT v_voicemail_greetings_pkey;
       public         	   fusionpbx    false    323                       2606    2164203 .   v_voicemail_messages v_voicemail_messages_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.v_voicemail_messages
    ADD CONSTRAINT v_voicemail_messages_pkey PRIMARY KEY (voicemail_message_uuid);
 X   ALTER TABLE ONLY public.v_voicemail_messages DROP CONSTRAINT v_voicemail_messages_pkey;
       public         	   fusionpbx    false    324                       2606    2164205 ,   v_voicemail_options v_voicemail_options_pkey 
   CONSTRAINT     }   ALTER TABLE ONLY public.v_voicemail_options
    ADD CONSTRAINT v_voicemail_options_pkey PRIMARY KEY (voicemail_option_uuid);
 V   ALTER TABLE ONLY public.v_voicemail_options DROP CONSTRAINT v_voicemail_options_pkey;
       public         	   fusionpbx    false    325                       2606    2164207    v_voicemails v_voicemails_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.v_voicemails
    ADD CONSTRAINT v_voicemails_pkey PRIMARY KEY (voicemail_uuid);
 H   ALTER TABLE ONLY public.v_voicemails DROP CONSTRAINT v_voicemails_pkey;
       public         	   fusionpbx    false    326                        2606    2164209    v_xml_cdr v_xml_cdr_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.v_xml_cdr
    ADD CONSTRAINT v_xml_cdr_pkey PRIMARY KEY (xml_cdr_uuid);
 B   ALTER TABLE ONLY public.v_xml_cdr DROP CONSTRAINT v_xml_cdr_pkey;
       public         	   fusionpbx    false    327           