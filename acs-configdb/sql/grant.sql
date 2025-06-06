-- Factory+ / AMRC Connectivity Stack (ACS) Config Store component
-- DB permission grants.
-- Copyright 2024 University of Sheffield.

-- Revoke some unhelpful default permissions.
revoke all on database :"db" from public;
revoke all on schema public from public;

-- Grant permissions.
grant connect, temporary on database :"db" to :"role";
grant usage on schema public to :"role";
grant select on
    version, all_class, all_subclass, all_membership, any_child
to :"role";
grant select, insert, update, delete on
    object, config, membership, subclass, rank
to :"role";
grant usage on
    object_id_seq, config_id_seq
to :"role";
