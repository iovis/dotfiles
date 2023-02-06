function pycache --wraps=find\ .\ -name\ \'\*.pyc\'\ -exec\ rm\ \{\}\ \\\; --description alias\ pycache=find\ .\ -name\ \'\*.pyc\'\ -exec\ rm\ \{\}\ \\\;
    find . -name '*.pyc' -exec rm {} \; $argv
end
