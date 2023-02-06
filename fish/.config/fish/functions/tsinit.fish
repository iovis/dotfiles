function tsinit --wraps='yarn add --dev ts-node typescript @types/node' --description 'alias tsinit=yarn add --dev ts-node typescript @types/node'
    yarn add --dev ts-node typescript @types/node $argv
end
