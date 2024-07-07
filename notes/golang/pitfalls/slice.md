# slice pitfalls

* append

A slice is a reference to an underlying array.
If two slices share the underlying array, changing
one slice ***MAY*** affects another one.

```golang
func printSlice(s []int) {
	fmt.Printf("len=%d, cap=%d, s=%v\n", len(s), cap(s), s)
}

func main() {
	s1 := []int{1}
	s2 := s1
	printSlice(s1) // len=1, cap=1, s=[1]

	s1 = append(s1, 2)
	s2 = append(s2, 5) // <--- it will not change s1
	printSlice(s1)     // len=2, cap=2, s=[1 2]
	printSlice(s2)     // len=2, cap=2, s=[1 5]

	s1 = append(s1, 3, 4, 5, 6, 7)
	s2 = s1
	printSlice(s1) // len=7, cap=8, s=[1 2 3 4 5 6 7]
	printSlice(s2) // len=7, cap=8, s=[1 2 3 4 5 6 7]

	s1 = append(s1, 8)
	printSlice(s1)     // len=8, cap=8, s=[1 2 3 4 5 6 7 8]
	printSlice(s2)     // len=7, cap=8, s=[1 2 3 4 5 6 7]

	s2 = append(s2, 9) // <---- it will change s1
	printSlice(s1)     // len=8, cap=8, s=[1 2 3 4 5 6 7 9]
	printSlice(s2)     // len=8, cap=8, s=[1 2 3 4 5 6 7 9]

}

```
