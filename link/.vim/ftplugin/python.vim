let ale_fix_on_save = 1

function! DockerTransform(cmd) abort
  return ' docker-compose -f docker-compose.test.yml run --rm tests ' . a:cmd
endfunction

let g:test#custom_transformations = {'docker': function('DockerTransform')}
let g:test#transformation = 'docker'
let test#python#runner = 'pytest'
let test#python#pytest#executable = 'python -m pytest'
