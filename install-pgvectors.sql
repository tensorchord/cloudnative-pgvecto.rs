ALTER SYSTEM SET shared_preload_libraries = "vectors.so"
ALTER SYSTEM SET search_path = "$user", public, vectors 
