open Str;;

let matched what where =
  Str.string_match (Str.regexp(".*" ^ what ^ ".*")) where 0
;;

let dir_contents dir =
  let rec loop result = function
    | f::fs when Sys.is_directory f ->
      Sys.readdir f
      |> Array.to_list
      |> List.map (Filename.concat f)
      |> List.filter (fun fileName -> not(matched "\\/node_modules\\/" fileName))
      |> List.filter (fun fileName -> not(matched "\\/.git\\/" fileName))
      |> List.filter (fun fileName -> not(matched "\\/.gradle\\/" fileName))
      |> List.filter (fun fileName -> not(matched "\\/.idea\\/" fileName))
      |> List.filter (fun fileName -> not(matched "\\/build\\/" fileName))
      |> List.filter (fun fileName -> not(matched "\\/buildSrc\\/" fileName))
      |> List.append fs
      |> loop result
    | f::fs -> loop (f::result) fs
    | []    -> result
  in
  loop [] [dir]
;;
