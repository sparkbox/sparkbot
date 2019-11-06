const { spawnSync }= require('child_process');
const name = process.env.NAME || 'sparkbot';

const arguments = ['--name', name];

if (process.env.NODE_ENV === "production") {
  arguments.push('-a', 'slack');
}

spawnSync('hubot', arguments, {stdio: 'inherit'});
