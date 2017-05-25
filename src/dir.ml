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

let fold_file f x file_name =
  let buffer = Bytes.create 1024 in
  let file = open_in file_name in
  let rec go a =
    let length = input file buffer 0 (String.length buffer) in
    let a' = f a (String.sub buffer 0 length) in
    if length > 0 then go a' else a' in
  let r = go x in
  close_in file;
  r;;

let count_newlines s =
  let rec go n i =
    try
      let i' = String.index_from s i '\n' in
      go (n + 1) (i' + 1)
    with Not_found -> n in
  go 0 0;;

let count_file_lines f =
  fold_file (fun x s -> x + count_newlines s) 0 f
;;
