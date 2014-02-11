#!/usr/bin/env bash
#
function handle_options(){
    # Parse user options
    #
    while getopts "dehiln:p" opt; do
      case $opt in

        # Set development's host file
        d)
            echo "-choose DEVELOPMENT!" >&2
            FILE="hosts.dev";
          ;;

        # Start editing one environment
        e)
            set_path;
            run_cmd "$DEFAULT_IDE $FILE_PATH$FILE";
          ;;

        # Set homolagtion's host file
        h)
            echo "-choose HOMOLOGATION!" >&2
            FILE="hosts.hml";
          ;;

        # create environment hosts
        i)            
            cmd_hosts_init; 
          ;;

        # Set localhost's host file
        l)
            echo "-choose LOCAL!" >&2
            FILE="hosts.lch";
          ;;

        n)
          if [ -n "$1" ]; then    
            network=${OPTARG}   
            ROUTER=$(networksetup -getinfo $network | grep '^Router:' | awk '{print $2}')
          else
            die "Invalid parameter for network: ${OPTARG}."
          fi
          ;;

        # Set production's host file
        p)  
            echo "-choose PRODUCTION!" >&2
            FILE="hosts.prd";
          ;;

        \?)
        echo "Invalid option: -$OPTARG" >&2
        exit 1
        ;;
        :)
        echo "Option -$OPTARG requires an argument." >&2
        exit 1    
        ;;
      esac
    done
}