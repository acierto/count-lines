open Dir ;;

let totalNumber =
  let filenames = Dir.dir_contents "/Users/bogdannechyporenko/proj/xld-ci-explorer" in
    List.fold_left (fun acc v -> acc + (Dir.count_file_lines v)) 0 filenames
;;

print_endline(string_of_int totalNumber);
