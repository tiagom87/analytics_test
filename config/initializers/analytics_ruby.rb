Analytics = Segment::Analytics.new({
    write_key: "1zB6ds1MjvbcRknDpEyTqCUmncHd5pPH",
    on_error: Proc.new { |status, msg| print msg }
})