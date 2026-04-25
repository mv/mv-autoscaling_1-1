

_ses='dev-01'
_dir='./terraform/live/dev/sa-east-1/'

tmux new -s ${_ses} -d             # new          -t %0

tmux split-window -h -t ${_ses} -d # split right  -t %1
tmux split-window -v -t ${_ses} -d # split down   -t %2
tmux select-pane  -R               # move  right
tmux split-window -v -t ${_ses}    # split down   -t %3

tmux send-keys -t %0 "cd ./deploy/ ; ls -l" C-m
tmux send-keys -t %1 "cd ${_dir}/customer-acme/ ; ls -l" C-m
tmux send-keys -t %2 "cd ${_dir}/" C-m
tmux send-keys -t %3 "cd ${_dir}/ ; ls -l" C-m

tmux attach -t ${_ses}
