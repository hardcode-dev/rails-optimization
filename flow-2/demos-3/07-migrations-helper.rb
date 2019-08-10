# Хелпер для миграций по добавлению столбца с дефолтным значением
# Also, see https://github.com/ilyakatz/data-migrate для миграций данных
module MigrationsHelper
  # Usage:
  #   include MigrationsHelper
  #   disable_ddl_transaction!
  #
  #   def up
  #     add_column_with_default :articles, :priority, :float, default: 1.0, null: false
  #   end
  #
  #   def down
  #     remove_column :articles, :priority
  #   end
  #
  # If null == true function:
  # - creates column without default
  # - changes column default
  #
  # If null == false function:
  # - creates column without default
  # - changes column default
  # - updates all column values to default value
  # - changes column null
  #
  # You need use disable_ddl_transaction! if null == false!
  #
  def add_column_with_default(table_name, column_name, column_type, default:, null: true, model_class: nil)
    if null == false && !disable_ddl_transaction
      raise 'Please add disable_ddl_transaction! to migration'
    end

    add_column(table_name, column_name, column_type)
    change_column_default(table_name, column_name, default)

    if null == false
      update_column_values(table_name, column_name, default, model_class)
      change_column_null(table_name, column_name, false)
    end
  rescue => e
    safety_assured { remove_column(table_name, column_name) }

    raise e
  end

  def update_column_values(table_name, column_name, value, model_class)
    puts "-- update_column_values(:#{table_name}, :#{column_name}, #{value})"

    model = model_class || detect_model(table_name)

    time =
      Benchmark.measure do
        model
          .in_batches(of: 10_000)
          .update_all(column_name => value)
      end

    puts "   -> #{"%.4fs" % time.real}"
  end

  def detect_model(table_name)
    model = ActiveRecord::Base.descendants.detect { |d| d.table_name == table_name.to_s }
    raise "Model for table #{table_name} not found. You can pass it explicitly!" unless model
    model
  end
end
