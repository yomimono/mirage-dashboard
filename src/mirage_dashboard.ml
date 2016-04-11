open Core.Std
open Lwt

let quite_pretty_json s = Yojson.Safe.pretty_to_string (Yojson.Safe.from_string s)

let first_str = function
  | [] -> "{}"
  | hd :: _ -> hd


let spec =
  let open Command.Spec in
  empty
    +> flag "-c" (required string) ~doc:"cookie github auth cookie, from git-jar"

let get_release_and_print_async ~cookie_name ~user ~repo =
    Github_wrapper.get_release
      ~cookie_name
      ~user
      ~repo
    >>= fun release ->
    Github_wrapper.release_to_list release
    >>= fun release_list ->
    Github_wrapper.release_strings release_list
    |> fun release_strings ->
    Lwt_io.printf "%s\n" (quite_pretty_json (first_str release_strings))

let get_release_async ~cookie_name ~user ~repo =
    Github_wrapper.get_release
      ~cookie_name
      ~user
      ~repo
    >>= fun release ->
        Github_wrapper.release_to_list release
    >>= fun release_list ->
        Github_wrapper.release_strings release_list
    |> fun release_strings ->
        return (first_str release_strings)

let all_repos =
    Dashboard_data.repo_list_from_json "data/repos.json"
    |> (fun repo_list ->
        List.map
        ~f:(
            fun repo ->
                match repo with
                | ((u_name, r_name), tags) -> (u_name, r_name)
        )
        repo_list
    )

let print_all_repos ~cookie_name all_repos =
    List.map
    ~f:(
        fun (user, repo) ->
            get_release_and_print_async ~cookie_name ~user:user ~repo:repo
    )
    all_repos

let get_all_repos ~cookie_name all_repos =
    Lwt_list.map_s
    (
        fun (user, repo) ->
            get_release_async ~cookie_name ~user:user ~repo:repo
    )
    all_repos

let command =
  Command.basic
    ~summary: "A dashboard displaying useful data from the Mirage OS project and its related repositories."
    ~readme: (fun () -> "More detailed info")
    spec
    (fun cookie_name () ->
       Lwt_main.run (
           (* Lwt.join (print_all_repos ~cookie_name all_repos) *)
           get_all_repos ~cookie_name all_repos
           >>= fun repos ->
               List.fold
               ~f:(fun accum repo_json_str ->
                    accum ^ repo_json_str)
               ~init:""
               repos
               |> fun long_invalid_json_str ->
                   Lwt_io.printf "%s\n" long_invalid_json_str
       )
    )

let () =
  Command.run ~version:"0.1" ~build_info:"https://github.com/rudenoise/mirage-dashboard" command
