package 'git'

directory node['prometheus']['exporters']['install_location'] do
  recursive true
end

git 'exporters' do
  repository 'https://github.com/sinkingpoint/prometheus-exporters.git'
  destination node['prometheus']['exporters']['install_location']
end

python_runtime '2'

python_virtualenv ::File.join(node['prometheus']['exporters']['install_location'], 'venv')
pip_requirements ::File.join(node['prometheus']['exporters']['install_location'], 'requirements.txt')