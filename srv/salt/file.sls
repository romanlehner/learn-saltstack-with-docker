copy test file:
  file.managed:
    - name: /test/file.txt
    - source: salt://test.txt
    - makedirs: True