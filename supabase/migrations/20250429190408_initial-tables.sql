create table "public"."answers" (
    "id" bigint generated by default as identity not null,
    "question_id" bigint not null,
    "answer_text" text not null
);


create table "public"."games" (
    "id" bigint generated by default as identity not null,
    "created_at" timestamp with time zone not null default now(),
    "created_by" uuid,
    "title" text,
    "description" text,
    "answer_window" bigint default '30'::bigint
);


create table "public"."participants" (
    "id" bigint generated by default as identity not null,
    "session_id" bigint not null,
    "username" text not null
);


create table "public"."points" (
    "id" bigint generated by default as identity not null,
    "participant_id" bigint not null,
    "question_id" bigint not null,
    "answer_id" bigint not null,
    "points_awarded" bigint not null default '0'::bigint
);


create table "public"."questions" (
    "id" bigint generated by default as identity not null,
    "game_id" bigint not null,
    "content" text not null
);


create table "public"."sessions" (
    "id" bigint generated by default as identity not null,
    "game_id" bigint,
    "started_at" timestamp with time zone not null default now(),
    "current_question_id" bigint,
    "started_by_user_id" uuid not null,
    "ended_at" timestamp without time zone,
    "open" boolean not null default false
);


create table "public"."users_games" (
    "game_user_id" uuid not null,
    "game_id" bigint generated by default as identity not null
);


CREATE UNIQUE INDEX answers_pkey ON public.answers USING btree (id);

CREATE UNIQUE INDEX games_pkey ON public.games USING btree (id);

CREATE UNIQUE INDEX participants_pkey ON public.participants USING btree (id);

CREATE UNIQUE INDEX points_pkey ON public.points USING btree (id);

CREATE UNIQUE INDEX questions_pkey ON public.questions USING btree (id);

CREATE UNIQUE INDEX sessions_pkey ON public.sessions USING btree (id);

CREATE UNIQUE INDEX users_games_pkey ON public.users_games USING btree (game_user_id, game_id);

alter table "public"."answers" add constraint "answers_pkey" PRIMARY KEY using index "answers_pkey";

alter table "public"."games" add constraint "games_pkey" PRIMARY KEY using index "games_pkey";

alter table "public"."participants" add constraint "participants_pkey" PRIMARY KEY using index "participants_pkey";

alter table "public"."points" add constraint "points_pkey" PRIMARY KEY using index "points_pkey";

alter table "public"."questions" add constraint "questions_pkey" PRIMARY KEY using index "questions_pkey";

alter table "public"."sessions" add constraint "sessions_pkey" PRIMARY KEY using index "sessions_pkey";

alter table "public"."users_games" add constraint "users_games_pkey" PRIMARY KEY using index "users_games_pkey";

alter table "public"."answers" add constraint "answers_question_id_fkey" FOREIGN KEY (question_id) REFERENCES questions(id) ON DELETE CASCADE not valid;

alter table "public"."answers" validate constraint "answers_question_id_fkey";

alter table "public"."games" add constraint "games_created_by_fkey" FOREIGN KEY (created_by) REFERENCES auth.users(id) ON DELETE CASCADE not valid;

alter table "public"."games" validate constraint "games_created_by_fkey";

alter table "public"."participants" add constraint "participants_session_id_fkey" FOREIGN KEY (session_id) REFERENCES sessions(id) ON DELETE CASCADE not valid;

alter table "public"."participants" validate constraint "participants_session_id_fkey";

alter table "public"."points" add constraint "points_answer_id_fkey" FOREIGN KEY (answer_id) REFERENCES answers(id) ON DELETE CASCADE not valid;

alter table "public"."points" validate constraint "points_answer_id_fkey";

alter table "public"."points" add constraint "points_participant_id_fkey" FOREIGN KEY (participant_id) REFERENCES participants(id) ON DELETE CASCADE not valid;

alter table "public"."points" validate constraint "points_participant_id_fkey";

alter table "public"."points" add constraint "points_question_id_fkey" FOREIGN KEY (question_id) REFERENCES questions(id) ON DELETE CASCADE not valid;

alter table "public"."points" validate constraint "points_question_id_fkey";

alter table "public"."questions" add constraint "questions_game_id_fkey" FOREIGN KEY (game_id) REFERENCES games(id) ON DELETE CASCADE not valid;

alter table "public"."questions" validate constraint "questions_game_id_fkey";

alter table "public"."sessions" add constraint "sessions_current_question_id_fkey" FOREIGN KEY (current_question_id) REFERENCES questions(id) not valid;

alter table "public"."sessions" validate constraint "sessions_current_question_id_fkey";

alter table "public"."sessions" add constraint "sessions_game_id_fkey" FOREIGN KEY (game_id) REFERENCES games(id) not valid;

alter table "public"."sessions" validate constraint "sessions_game_id_fkey";

alter table "public"."sessions" add constraint "sessions_started_by_user_id_fkey" FOREIGN KEY (started_by_user_id) REFERENCES auth.users(id) not valid;

alter table "public"."sessions" validate constraint "sessions_started_by_user_id_fkey";

alter table "public"."users_games" add constraint "users_games_game_id_fkey" FOREIGN KEY (game_id) REFERENCES games(id) ON DELETE CASCADE not valid;

alter table "public"."users_games" validate constraint "users_games_game_id_fkey";

alter table "public"."users_games" add constraint "users_games_game_user_id_fkey" FOREIGN KEY (game_user_id) REFERENCES auth.users(id) ON DELETE CASCADE not valid;

alter table "public"."users_games" validate constraint "users_games_game_user_id_fkey";

grant delete on table "public"."answers" to "anon";

grant insert on table "public"."answers" to "anon";

grant references on table "public"."answers" to "anon";

grant select on table "public"."answers" to "anon";

grant trigger on table "public"."answers" to "anon";

grant truncate on table "public"."answers" to "anon";

grant update on table "public"."answers" to "anon";

grant delete on table "public"."answers" to "authenticated";

grant insert on table "public"."answers" to "authenticated";

grant references on table "public"."answers" to "authenticated";

grant select on table "public"."answers" to "authenticated";

grant trigger on table "public"."answers" to "authenticated";

grant truncate on table "public"."answers" to "authenticated";

grant update on table "public"."answers" to "authenticated";

grant delete on table "public"."answers" to "service_role";

grant insert on table "public"."answers" to "service_role";

grant references on table "public"."answers" to "service_role";

grant select on table "public"."answers" to "service_role";

grant trigger on table "public"."answers" to "service_role";

grant truncate on table "public"."answers" to "service_role";

grant update on table "public"."answers" to "service_role";

grant delete on table "public"."games" to "anon";

grant insert on table "public"."games" to "anon";

grant references on table "public"."games" to "anon";

grant select on table "public"."games" to "anon";

grant trigger on table "public"."games" to "anon";

grant truncate on table "public"."games" to "anon";

grant update on table "public"."games" to "anon";

grant delete on table "public"."games" to "authenticated";

grant insert on table "public"."games" to "authenticated";

grant references on table "public"."games" to "authenticated";

grant select on table "public"."games" to "authenticated";

grant trigger on table "public"."games" to "authenticated";

grant truncate on table "public"."games" to "authenticated";

grant update on table "public"."games" to "authenticated";

grant delete on table "public"."games" to "service_role";

grant insert on table "public"."games" to "service_role";

grant references on table "public"."games" to "service_role";

grant select on table "public"."games" to "service_role";

grant trigger on table "public"."games" to "service_role";

grant truncate on table "public"."games" to "service_role";

grant update on table "public"."games" to "service_role";

grant delete on table "public"."participants" to "anon";

grant insert on table "public"."participants" to "anon";

grant references on table "public"."participants" to "anon";

grant select on table "public"."participants" to "anon";

grant trigger on table "public"."participants" to "anon";

grant truncate on table "public"."participants" to "anon";

grant update on table "public"."participants" to "anon";

grant delete on table "public"."participants" to "authenticated";

grant insert on table "public"."participants" to "authenticated";

grant references on table "public"."participants" to "authenticated";

grant select on table "public"."participants" to "authenticated";

grant trigger on table "public"."participants" to "authenticated";

grant truncate on table "public"."participants" to "authenticated";

grant update on table "public"."participants" to "authenticated";

grant delete on table "public"."participants" to "service_role";

grant insert on table "public"."participants" to "service_role";

grant references on table "public"."participants" to "service_role";

grant select on table "public"."participants" to "service_role";

grant trigger on table "public"."participants" to "service_role";

grant truncate on table "public"."participants" to "service_role";

grant update on table "public"."participants" to "service_role";

grant delete on table "public"."points" to "anon";

grant insert on table "public"."points" to "anon";

grant references on table "public"."points" to "anon";

grant select on table "public"."points" to "anon";

grant trigger on table "public"."points" to "anon";

grant truncate on table "public"."points" to "anon";

grant update on table "public"."points" to "anon";

grant delete on table "public"."points" to "authenticated";

grant insert on table "public"."points" to "authenticated";

grant references on table "public"."points" to "authenticated";

grant select on table "public"."points" to "authenticated";

grant trigger on table "public"."points" to "authenticated";

grant truncate on table "public"."points" to "authenticated";

grant update on table "public"."points" to "authenticated";

grant delete on table "public"."points" to "service_role";

grant insert on table "public"."points" to "service_role";

grant references on table "public"."points" to "service_role";

grant select on table "public"."points" to "service_role";

grant trigger on table "public"."points" to "service_role";

grant truncate on table "public"."points" to "service_role";

grant update on table "public"."points" to "service_role";

grant delete on table "public"."questions" to "anon";

grant insert on table "public"."questions" to "anon";

grant references on table "public"."questions" to "anon";

grant select on table "public"."questions" to "anon";

grant trigger on table "public"."questions" to "anon";

grant truncate on table "public"."questions" to "anon";

grant update on table "public"."questions" to "anon";

grant delete on table "public"."questions" to "authenticated";

grant insert on table "public"."questions" to "authenticated";

grant references on table "public"."questions" to "authenticated";

grant select on table "public"."questions" to "authenticated";

grant trigger on table "public"."questions" to "authenticated";

grant truncate on table "public"."questions" to "authenticated";

grant update on table "public"."questions" to "authenticated";

grant delete on table "public"."questions" to "service_role";

grant insert on table "public"."questions" to "service_role";

grant references on table "public"."questions" to "service_role";

grant select on table "public"."questions" to "service_role";

grant trigger on table "public"."questions" to "service_role";

grant truncate on table "public"."questions" to "service_role";

grant update on table "public"."questions" to "service_role";

grant delete on table "public"."sessions" to "anon";

grant insert on table "public"."sessions" to "anon";

grant references on table "public"."sessions" to "anon";

grant select on table "public"."sessions" to "anon";

grant trigger on table "public"."sessions" to "anon";

grant truncate on table "public"."sessions" to "anon";

grant update on table "public"."sessions" to "anon";

grant delete on table "public"."sessions" to "authenticated";

grant insert on table "public"."sessions" to "authenticated";

grant references on table "public"."sessions" to "authenticated";

grant select on table "public"."sessions" to "authenticated";

grant trigger on table "public"."sessions" to "authenticated";

grant truncate on table "public"."sessions" to "authenticated";

grant update on table "public"."sessions" to "authenticated";

grant delete on table "public"."sessions" to "service_role";

grant insert on table "public"."sessions" to "service_role";

grant references on table "public"."sessions" to "service_role";

grant select on table "public"."sessions" to "service_role";

grant trigger on table "public"."sessions" to "service_role";

grant truncate on table "public"."sessions" to "service_role";

grant update on table "public"."sessions" to "service_role";

grant delete on table "public"."users_games" to "anon";

grant insert on table "public"."users_games" to "anon";

grant references on table "public"."users_games" to "anon";

grant select on table "public"."users_games" to "anon";

grant trigger on table "public"."users_games" to "anon";

grant truncate on table "public"."users_games" to "anon";

grant update on table "public"."users_games" to "anon";

grant delete on table "public"."users_games" to "authenticated";

grant insert on table "public"."users_games" to "authenticated";

grant references on table "public"."users_games" to "authenticated";

grant select on table "public"."users_games" to "authenticated";

grant trigger on table "public"."users_games" to "authenticated";

grant truncate on table "public"."users_games" to "authenticated";

grant update on table "public"."users_games" to "authenticated";

grant delete on table "public"."users_games" to "service_role";

grant insert on table "public"."users_games" to "service_role";

grant references on table "public"."users_games" to "service_role";

grant select on table "public"."users_games" to "service_role";

grant trigger on table "public"."users_games" to "service_role";

grant truncate on table "public"."users_games" to "service_role";

grant update on table "public"."users_games" to "service_role";



