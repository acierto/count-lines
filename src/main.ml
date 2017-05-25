open Dir ;;

let printlist l = List.iter (fun x -> print_endline x) l;;

printlist (Dir.dir_contents "/Users/bogdannechyporenko/proj/xld-ci-explorer");;
