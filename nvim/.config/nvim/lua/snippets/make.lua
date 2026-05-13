return {
  s(
    "init",
    fmt(
      [[
        CC = clang
        SANITIZE_FLAGS ?= -fsanitize=address,undefined -fno-omit-frame-pointer
        CFLAGS ?= -std=c23 -Wall -Wextra -Wpedantic -g $(SANITIZE_FLAGS)
        RELEASE_CFLAGS ?= -std=c23 -Wall -Wextra -Wpedantic -O3 -DNDEBUG

        TARGET := $(notdir $(CURDIR))
        BUILD_DIR := build
        DEBUG_DIR := $(BUILD_DIR)/debug
        RELEASE_DIR := $(BUILD_DIR)/release
        SRC := $(wildcard c/*.c)
        APP_SRC := $(filter-out c/main_test.c,$(SRC))
        TEST_SRC := $(filter-out c/main.c,$(SRC))
        BIN := $(DEBUG_DIR)/$(TARGET)
        RELEASE_BIN := $(RELEASE_DIR)/$(TARGET)
        TEST_BIN := $(DEBUG_DIR)/$(TARGET)_test

        .DEFAULT_GOAL := all

        .PHONY: all run release run_release test compiledb clean

        all: $(BIN)

        run: $(BIN)
        	$(BIN)

        release: $(RELEASE_BIN)

        run_release: $(RELEASE_BIN)
        	$(RELEASE_BIN)

        test: $(TEST_BIN)
        	$(TEST_BIN)

        compiledb:
        	bear -- $(MAKE) clean all test

        $(BIN): $(APP_SRC) | $(DEBUG_DIR)
        	$(CC) $(CFLAGS) -o $@ $^

        $(RELEASE_BIN): $(APP_SRC) | $(RELEASE_DIR)
        	$(CC) $(RELEASE_CFLAGS) -o $@ $^

        $(TEST_BIN): $(TEST_SRC) | $(DEBUG_DIR)
        	$(CC) $(CFLAGS) -DTEST -o $@ $^

        $(DEBUG_DIR) $(RELEASE_DIR):
        	mkdir -p $@

        clean:
        	rm -rf $(BUILD_DIR)
      ]],
      {}
    ),
    { condition = conds.line_begin }
  ),
}
