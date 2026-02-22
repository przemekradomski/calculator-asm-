# calculator.asm

Prosty kalkulator napisany w asemblerze x86-64 Linux, który dodaje dwie liczby całkowite.

## Opis

Program `calculator.asm` jest implementacją prostego kalkulatora w czystym asemblerze. Jego główna funkcjonalność to:

1. **Wczytanie dwóch liczb** — Program czeka na wprowadzenie dwóch liczb całkowitych ze standardowego wejścia
2. **Konwersja** — Tekst wejściowy jest konwertowany na wartości liczbowe
3. **Dodawanie** — Dwie liczby są dodane do siebie
4. **Wynik** — Wynik jest konwertowany z powrotem na tekst i wypisywany na standardowe wyjście

## Wymagania

- **System operacyjny**: Linux x86-64
- **Assembler**: NASM (Netwide Assembler)
- **Linker**: ld

## Kompilacja i uruchomienie

### Kompilacja
```bash
nasm -f elf64 calculator.asm -o calculator.o
ld calculator.o -o calculator
```

### Uruchomienie
```bash
./calculator
```

Program będzie czekać na wpisanie dwóch liczb. Każdą liczbę wpisz w osobnej linii i naciśnij Enter.

**Przykład:**
```
5
3
8
```

W tym przypadku program wypisze `8` (wynik 5 + 3).

## Struktura programu

### Sekcje
- **`.bss`** — Zmienne niezainicjalizowane (bufory do przechowywania liczb)
- **`.text`** — Kod programu

### Funkcje

#### `_start`
Główny punkt wejścia programu:
- Wczytuje pierwszą liczbę przy użyciu syscall (read)
- Konwertuje ją do formatu liczbowego
- Wczytuje drugą liczbę
- Dodaje obie liczby
- Konwertuje wynik do formatu tekstowego
- Wypisuje rezultat
- Kończy program (exit)

#### `atoi`
Konwertuje ciąg znaków na liczbę całkowitą:
- Czyta każdy znak z bufora
- Zamienia znak ASCII cyfry na wartość liczbową
- Wykorzystuje operację mnożenia przez 10 do przesunięcia pozycji
- Zwraca wynik w rejestrze `rax`

#### `itoa`
Konwertuje liczbę całkowitą na ciąg znaków:
- Dzieli liczbę przez 10 i zbiera reszty
- Konwertuje reszty na znaki ASCII
- Przechowuje wynik w buforze
- Zwraca wskaźnik do wyniku w rejestrze `rbx`

## Rejestry
- **`rax`** — Przechowuje operandy i wynik operacji
- **`r12`** — Przechowuje pierwszą liczbę
- **`rsi`** — Wskaźnik do bufora wejściowego
- **`rbx`** — Wskaźnik do bufora wyjściowego
- **`rdx`** — Rozmiar danych oraz reszta z dzielenia
- **`rdi`** — Deskryptor pliku (0=stdin, 1=stdout)

## Ograniczenia

- Bufory mogą przechowywać maksymalnie 16 bajtów
- Program obsługuje tylko liczby całkowite
- Bieżąca implementacja obsługuje tylko **dodawanie**
- Program nie validates poprawności wejścia (zakłada poprawne liczby)

## Notatki

Program korzysta z systemowych wywołań (syscalls):
- **syscall 0** — read (wczytanie)
- **syscall 1** — write (wypisanie)
- **syscall 60** — exit (zakończenie)

Te syscalle są specyficzne dla Linuxa x86-64.

---

*Autor: Przemek Radomski
*Język: x86-64 Assembly*
*Platforma: Linux*
---

**Autor**: [Github]://github.com/przemekradomski)
**Repository**: [Link do projektu](https://github.com/przemekradomski/calculator-asm)
