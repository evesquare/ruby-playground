# ファイルを読み込んでTodoリストを管理するプログラム
# ファイルはjson形式で保存します
# {
#     "todos": [
#         {
#             "id": 1,
#             "title": "洗濯",
#         },
#         {
#             "id": 2,
#             "title": "ご飯",
#         }
#     ]
# }
# a タスク名でタスクを追加する
# d タスク名でタスクを削除する
# l タスク一覧を表示する

require 'json'

# タスク管理用のクラス

class Task
  attr_accessor :id, :title

  def initialize(id, title)
    @id = id
    @title = title
  end
end

# タスク管理用のクラス

class TaskManager
  def initialize
    @tasks = []
  end

  def add(title)
    @tasks << Task.new(next_id, title)
  end

  def delete(title)
    task = @tasks.find { |task| task.title == title }
    @tasks.delete(task)
  end

  def list
    @tasks.each do |task|
      puts "#{task.id}: #{task.title}"
    end
  end

  private

  def next_id
    @tasks.empty? ? 1 : @tasks.last.id + 1
  end
end

# ファイルの読み込み

def load_tasks
  json = File.read('tasks.json')
  tasks = JSON.parse(json)
  task_manager = TaskManager.new
  tasks['todos'].each do |task|
    task_manager.add(task['title'])
  end
  task_manager
rescue Errno::ENOENT
  TaskManager.new
end

# ファイルへの書き込み

def save_tasks(task_manager)
  tasks = { 'todos' => task_manager.instance_variable_get(:@tasks) }
  File.write('tasks.json', JSON.generate(tasks))
end

# メイン処理

task_manager = load_tasks

puts 'a タスク名でタスクを追加する'
puts 'd タスク名でタスクを削除する'
puts 'l タスク一覧を表示する'
puts 'e 終了する'
while true
  puts 'コマンドを入力してください'
  command = gets.chomp

  case command
  when 'a'
    puts 'タスク名を入力してください'
    title = gets.chomp
    task_manager.add(title)
    save_tasks(task_manager)
  when 'd'
    puts '削除するタスク名を入力してください'
    title = gets.chomp
    task_manager.delete(title)
    save_tasks(task_manager)
  when 'l'
    task_manager.list
  when 'e'
    break
  else
    puts '無効なコマンドです'
  end
end

# タスクの保存

save_tasks(task_manager)
