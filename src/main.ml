open Dir ;;

let () =
  let results = Dir.dir_contents "/Users/bogdannechyporenko/proj/xld-ci-explorer" in
  List.iter print_endline results;
;;
