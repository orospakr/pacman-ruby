require "ffi"

module ALPM
  extend FFI::Library
  ffi_lib "libalpm"

  Error = enum(:none, 0,
               :memory,
               :system,
               :badperms,
               :not_a_file,
               :wrong_args,
               :disk_space)

  attach_function :alpm_logaction, [:pointer, :string, :string, :varargs], :int

  attach_function :_initialize, :alpm_initialize, [:string, :string, :pointer], :pointer
  
  def ALPM.init(root_path, db_path)
    error = FFI::MemoryPointer.new :uint, 1
    _initialize root_path, db_path, error
    if Error[error.read_uint] != :none
      raise "Oh crap: alpm error: #{Error[error.read_uint]}"
    end
  end
end

  
