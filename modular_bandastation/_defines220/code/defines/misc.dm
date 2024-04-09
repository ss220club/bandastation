///Do (almost) nothing - indev placeholder for switch case implementations etc
#define NOOP (.=.)
/// Copies the L from element START to elememt END if L is initialized, otherwise returns an empty list.
#define LAZYCOPY_RANGE(L, START, END) ( L ? L.Copy(START, END) : list() )
/// Cuts the L from element START to elememt END if L is initialized, otherwise returns an empty list.
#define LAZYCUT(L, START, END) ( L ? L.Cut(START, END) : NOOP )

#define rustg_file_write_b64decode(text, fname) RUSTG_CALL(RUST_G, "file_write")(text, fname, "true")

// Text Operations //
#define rustg_cyrillic_to_latin(text) RUSTG_CALL(RUST_G, "cyrillic_to_latin")("[text]")
#define rustg_latin_to_cyrillic(text) RUSTG_CALL(RUST_G, "latin_to_cyrillic")("[text]")
