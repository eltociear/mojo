# ===----------------------------------------------------------------------=== #
#
# This file is Modular Inc proprietary.
#
# ===----------------------------------------------------------------------=== #
"""Implements the DType class.

These are Mojo built-ins, so you don't need to import them.
"""

from collections.dict import KeyElement
from sys.info import sizeof as _sizeof

from algorithm.functional import unroll


@value
@register_passable("trivial")
struct DType(Stringable, KeyElement):
    """Represents DType and provides methods for working with it."""

    alias type = __mlir_type.`!kgen.dtype`
    var value: Self.type
    """The underlying storage for the DType value."""

    alias invalid = DType(
        __mlir_attr.`#kgen.dtype.constant<invalid> : !kgen.dtype`
    )
    """Represents an invalid or unknown data type."""
    alias bool = DType(__mlir_attr.`#kgen.dtype.constant<bool> : !kgen.dtype`)
    """Represents a boolean data type."""
    alias int8 = DType(__mlir_attr.`#kgen.dtype.constant<si8> : !kgen.dtype`)
    """Represents a signed integer type whose bitwidth is 8."""
    alias uint8 = DType(__mlir_attr.`#kgen.dtype.constant<ui8> : !kgen.dtype`)
    """Represents an unsigned integer type whose bitwidth is 8."""
    alias int16 = DType(__mlir_attr.`#kgen.dtype.constant<si16> : !kgen.dtype`)
    """Represents a signed integer type whose bitwidth is 16."""
    alias uint16 = DType(__mlir_attr.`#kgen.dtype.constant<ui16> : !kgen.dtype`)
    """Represents an unsigned integer type whose bitwidth is 16."""
    alias int32 = DType(__mlir_attr.`#kgen.dtype.constant<si32> : !kgen.dtype`)
    """Represents a signed integer type whose bitwidth is 32."""
    alias uint32 = DType(__mlir_attr.`#kgen.dtype.constant<ui32> : !kgen.dtype`)
    """Represents an unsigned integer type whose bitwidth is 32."""
    alias int64 = DType(__mlir_attr.`#kgen.dtype.constant<si64> : !kgen.dtype`)
    """Represents a signed integer type whose bitwidth is 64."""
    alias uint64 = DType(__mlir_attr.`#kgen.dtype.constant<ui64> : !kgen.dtype`)
    """Represents an unsigned integer type whose bitwidth is 64."""
    alias bfloat16 = DType(
        __mlir_attr.`#kgen.dtype.constant<bf16> : !kgen.dtype`
    )
    """Represents a brain floating point value whose bitwidth is 16."""
    alias float16 = DType(__mlir_attr.`#kgen.dtype.constant<f16> : !kgen.dtype`)
    """Represents an IEEE754-2008 `binary16` floating point value."""
    alias float32 = DType(__mlir_attr.`#kgen.dtype.constant<f32> : !kgen.dtype`)
    """Represents an IEEE754-2008 `binary32` floating point value."""
    alias tensor_float32 = DType(
        __mlir_attr.`#kgen.dtype.constant<tf32> : !kgen.dtype`
    )
    """Represents a special floating point format supported by NVIDIA Tensor
    Cores, with the same range as float32 and reduced precision (>=10 bits).
    Note that this type is only available on NVIDIA GPUs.
    """
    alias float64 = DType(__mlir_attr.`#kgen.dtype.constant<f64> : !kgen.dtype`)
    """Represents an IEEE754-2008 `binary64` floating point value."""
    alias index = DType(__mlir_attr.`#kgen.dtype.constant<index> : !kgen.dtype`)
    """Represents an integral type whose bitwidth is the maximum integral value
    on the system."""
    alias address = DType(
        __mlir_attr.`#kgen.dtype.constant<address> : !kgen.dtype`
    )
    """Represents a pointer type whose bitwidth is the same as the bitwidth
    of the hardware's pointer type (32-bit on 32-bit machines and 64-bit on
    64-bit machines)."""

    @always_inline("nodebug")
    fn __str__(self) -> String:
        """Gets the name of the DType.

        Returns:
            The name of the dtype.
        """
        if self == DType.bool:
            return "bool"
        if self == DType.int8:
            return "int8"
        if self == DType.uint8:
            return "uint8"
        if self == DType.int16:
            return "int16"
        if self == DType.uint16:
            return "uint16"
        if self == DType.int32:
            return "int32"
        if self == DType.uint32:
            return "uint32"
        if self == DType.int64:
            return "int64"
        if self == DType.uint64:
            return "uint64"
        if self == DType.index:
            return "index"
        if self == DType.bfloat16:
            return "bfloat16"
        if self == DType.float16:
            return "float16"
        if self == DType.float32:
            return "float32"
        if self == DType.tensor_float32:
            return "tensor_float32"
        if self == DType.float64:
            return "float64"
        if self == DType.invalid:
            return "invalid"
        if self == DType.address:
            return "address"
        return "<<unknown>>"

    @always_inline("nodebug")
    fn get_value(self) -> __mlir_type.`!kgen.dtype`:
        """Gets the associated internal kgen.dtype value.

        Returns:
            The kgen.dtype value.
        """
        return self.value

    @staticmethod
    fn _from_ui8(ui8: __mlir_type.ui8) -> DType:
        return __mlir_op.`pop.dtype.from_ui8`(ui8)

    @staticmethod
    fn _from_ui8(ui8: __mlir_type.`!pop.scalar<ui8>`) -> DType:
        return DType._from_ui8(
            __mlir_op.`pop.cast_to_builtin`[_type = __mlir_type.`ui8`](ui8)
        )

    @always_inline("nodebug")
    fn _as_i8(
        self,
    ) -> __mlir_type.`!pop.scalar<ui8>`:
        let val = __mlir_op.`pop.dtype.to_ui8`(self.value)
        return __mlir_op.`pop.cast_from_builtin`[
            _type = __mlir_type.`!pop.scalar<ui8>`
        ](val)

    @always_inline("nodebug")
    fn __eq__(self, rhs: DType) -> Bool:
        """Compares one DType to another for equality.

        Args:
            rhs: The DType to compare against.

        Returns:
            True if the DTypes are the same and False otherwise.
        """
        return __mlir_op.`pop.cmp`[pred = __mlir_attr.`#pop<cmp_pred eq>`](
            self._as_i8(), rhs._as_i8()
        )

    @always_inline("nodebug")
    fn __ne__(self, rhs: DType) -> Bool:
        """Compares one DType to another for non-equality.

        Args:
            rhs: The DType to compare against.

        Returns:
            False if the DTypes are the same and True otherwise.
        """
        return __mlir_op.`pop.cmp`[pred = __mlir_attr.`#pop<cmp_pred ne>`](
            self._as_i8(), rhs._as_i8()
        )

    fn __hash__(self) -> Int:
        return hash(UInt8(self._as_i8()))

    @always_inline("nodebug")
    fn isa[other: DType](self) -> Bool:
        """Checks if this DType matches the other one, specified as a
        parameter.

        Parameters:
            other: The DType to compare against.

        Returns:
            True if the DTypes are the same and False otherwise.
        """
        return self == other

    @always_inline("nodebug")
    fn is_bool(self) -> Bool:
        """Checks if this DType is Bool.

        Returns:
            True if the DType is Bool and False otherwise.
        """
        return self.isa[DType.bool]()

    @always_inline("nodebug")
    fn is_uint8(self) -> Bool:
        """Checks if this DType is UInt8.

        Returns:
            True if the DType is UInt8 and False otherwise.
        """
        return self.isa[DType.uint8]()

    @always_inline("nodebug")
    fn is_int8(self) -> Bool:
        """Checks if this DType is Int8.

        Returns:
            True if the DType is Int8 and False otherwise.
        """
        return self.isa[DType.int8]()

    @always_inline("nodebug")
    fn is_uint16(self) -> Bool:
        """Checks if this DType is UInt16.

        Returns:
            True if the DType is UInt16 and False otherwise.
        """
        return self.isa[DType.uint16]()

    @always_inline("nodebug")
    fn is_int16(self) -> Bool:
        """Checks if this DType is Int16.

        Returns:
            True if the DType is Int16 and False otherwise.
        """
        return self.isa[DType.int16]()

    @always_inline("nodebug")
    fn is_uint32(self) -> Bool:
        """Checks if this DType is UInt32.

        Returns:
            True if the DType is UInt32 and False otherwise.
        """
        return self.isa[DType.uint32]()

    @always_inline("nodebug")
    fn is_int32(self) -> Bool:
        """Checks if this DType is Int32.

        Returns:
            True if the DType is Int32 and False otherwise.
        """
        return self.isa[DType.int32]()

    @always_inline("nodebug")
    fn is_uint64(self) -> Bool:
        """Checks if this DType is UInt64.

        Returns:
            True if the DType is UInt64 and False otherwise.
        """
        return self.isa[DType.uint64]()

    @always_inline("nodebug")
    fn is_int64(self) -> Bool:
        """Checks if this DType is Int64.

        Returns:
            True if the DType is Int64 and False otherwise.
        """
        return self.isa[DType.int64]()

    @always_inline("nodebug")
    fn is_bfloat16(self) -> Bool:
        """Checks if this DType is BFloat16.

        Returns:
            True if the DType is BFloat16 and False otherwise.
        """
        return self.isa[DType.bfloat16]()

    @always_inline("nodebug")
    fn is_float16(self) -> Bool:
        """Checks if this DType is Float16.

        Returns:
            True if the DType is Float16 and False otherwise.
        """
        return self.isa[DType.float16]()

    @always_inline("nodebug")
    fn is_float32(self) -> Bool:
        """Checks if this DType is Float32.

        Returns:
            True if the DType is Float32 and False otherwise.
        """
        return self.isa[DType.float32]()

    @always_inline("nodebug")
    fn is_tensor_float32(self) -> Bool:
        """Checks if this DType is Tensor Float32.

        Returns:
            True if the DType is Tensor Float32 and False otherwise.
        """
        return self.isa[DType.tensor_float32]()

    @always_inline("nodebug")
    fn is_float64(self) -> Bool:
        """Checks if this DType is Float64.

        Returns:
            True if the DType is Float64 and False otherwise.
        """
        return self.isa[DType.float64]()

    @always_inline("nodebug")
    fn is_index(self) -> Bool:
        """Checks if this DType is Index.

        Returns:
            True if the DType is Index and False otherwise.
        """
        return self.isa[DType.index]()

    @always_inline("nodebug")
    fn is_address(self) -> Bool:
        """Checks if this DType is Address.

        Returns:
            True if the DType is Address and False otherwise.
        """
        return self.isa[DType.address]()

    @always_inline("nodebug")
    fn is_unsigned(self) -> Bool:
        """Returns True if the type parameter is unsigned and False otherwise.

        Returns:
            Returns True if the input type parameter is unsigned.
        """
        if not self.is_integral():
            return False
        let val = __mlir_op.`pop.dtype.to_ui8`(self.value)
        let ui8 = __mlir_op.`pop.cast_from_builtin`[
            _type = __mlir_type.`!pop.scalar<ui8>`
        ](val)
        var _mIsSigned = __mlir_op.`kgen.param.constant`[
            _type = __mlir_type[`!pop.scalar<ui8>`],
            value = __mlir_attr[`#pop.simd<1> : !pop.scalar<ui8>`],
        ]()
        return Bool(
            __mlir_op.`pop.cmp`[pred = __mlir_attr.`#pop<cmp_pred eq>`](
                __mlir_op.`pop.and`(ui8, _mIsSigned),
                __mlir_op.`kgen.param.constant`[
                    _type = __mlir_type[`!pop.scalar<ui8>`],
                    value = __mlir_attr[`#pop.simd<0> : !pop.scalar<ui8>`],
                ](),
            )
        )

    @always_inline("nodebug")
    fn is_signed(self) -> Bool:
        """Returns True if the type parameter is signed and False otherwise.

        Returns:
            Returns True if the input type parameter is signed.
        """
        if self.is_index() or self.is_floating_point():
            return True
        if not self.is_integral():
            return False
        let val = __mlir_op.`pop.dtype.to_ui8`(self.value)
        let ui8 = __mlir_op.`pop.cast_from_builtin`[
            _type = __mlir_type.`!pop.scalar<ui8>`
        ](val)
        var _mIsSigned = __mlir_op.`kgen.param.constant`[
            _type = __mlir_type[`!pop.scalar<ui8>`],
            value = __mlir_attr[`#pop.simd<1> : !pop.scalar<ui8>`],
        ]()
        return Bool(
            __mlir_op.`pop.cmp`[pred = __mlir_attr.`#pop<cmp_pred ne>`](
                __mlir_op.`pop.and`(ui8, _mIsSigned),
                __mlir_op.`kgen.param.constant`[
                    _type = __mlir_type[`!pop.scalar<ui8>`],
                    value = __mlir_attr[`#pop.simd<0> : !pop.scalar<ui8>`],
                ](),
            )
        )

    @always_inline("nodebug")
    fn is_integral(self) -> Bool:
        """Returns True if the type parameter is an integer and False otherwise.

        Returns:
            Returns True if the input type parameter is an integer.
        """
        if self.is_index():
            return True
        let val = __mlir_op.`pop.dtype.to_ui8`(self.value)
        let ui8 = __mlir_op.`pop.cast_from_builtin`[
            _type = __mlir_type.`!pop.scalar<ui8>`
        ](val)
        var _mIsInteger = __mlir_op.`kgen.param.constant`[
            _type = __mlir_type[`!pop.scalar<ui8>`],
            value = __mlir_attr[`#pop.simd<128> : !pop.scalar<ui8>`],
        ]()
        return Bool(
            __mlir_op.`pop.cmp`[pred = __mlir_attr.`#pop<cmp_pred ne>`](
                __mlir_op.`pop.and`(ui8, _mIsInteger),
                __mlir_op.`kgen.param.constant`[
                    _type = __mlir_type[`!pop.scalar<ui8>`],
                    value = __mlir_attr[`#pop.simd<0> : !pop.scalar<ui8>`],
                ](),
            )
        )

    @always_inline("nodebug")
    fn is_floating_point(self) -> Bool:
        """Returns True if the type parameter is a floating-point and False
        otherwise.

        Returns:
            Returns True if the input type parameter is a floating-point.
        """
        if self.is_integral():
            return False
        let val = __mlir_op.`pop.dtype.to_ui8`(self.value)
        let ui8 = __mlir_op.`pop.cast_from_builtin`[
            _type = __mlir_type.`!pop.scalar<ui8>`
        ](val)
        var _mIsFloat = __mlir_op.`kgen.param.constant`[
            _type = __mlir_type[`!pop.scalar<ui8>`],
            value = __mlir_attr[`#pop.simd<64> : !pop.scalar<ui8>`],
        ]()
        return Bool(
            __mlir_op.`pop.cmp`[pred = __mlir_attr.`#pop<cmp_pred ne>`](
                __mlir_op.`pop.and`(ui8, _mIsFloat),
                __mlir_op.`kgen.param.constant`[
                    _type = __mlir_type[`!pop.scalar<ui8>`],
                    value = __mlir_attr[`#pop.simd<0> : !pop.scalar<ui8>`],
                ](),
            )
        )

    @always_inline("nodebug")
    fn is_numeric(self) -> Bool:
        """Returns True if the type parameter is numeric (i.e. you can perform
        arithmetic operations on).

        Returns:
            Returns True if the input type parameter is either integral or
              floating-point.
        """
        return self.is_integral() or self.is_floating_point()

    @always_inline
    fn sizeof(self) -> Int:
        """Returns the size in bytes of the current DType.

        Returns:
            Returns the size in bytes of the current DType and -1 if the size is
            unknown.
        """
        alias type_list = VariadicList[DType](
            DType.bool,
            DType.int8,
            DType.uint8,
            DType.int16,
            DType.uint16,
            DType.bfloat16,
            DType.float16,
            DType.int32,
            DType.uint32,
            DType.float32,
            DType.tensor_float32,
            DType.int64,
            DType.uint64,
            DType.float64,
            DType.index,
            DType.address,
        )
        var size = -1

        @parameter
        @always_inline
        fn func[idx: Int]():
            if type_list[idx] == self:
                size = _sizeof[type_list[idx]]()
                return

        unroll[func, len(type_list)]()

        return size

    @always_inline
    fn bitwidth(self) -> Int:
        """Returns the size in bits of the current DType.

        Returns:
            Returns the size in bits of the current DType and -1 if the size is
            unknown.
        """
        let size_in_bytes = self.sizeof()
        return 8 * size_in_bytes if size_in_bytes > 0 else -1

    # ===----------------------------------------------------------------------===#
    # dispatch_integral
    # ===----------------------------------------------------------------------===#

    @always_inline
    fn dispatch_integral[
        func: fn[type: DType] () capturing -> None
    ](self) raises:
        """Dispatches an integral function corresponding to the current DType.

        Constraints:
            DType must be integral.

        Parameters:
            func: A parametrized on dtype function to dispatch.
        """
        if self.is_uint8():
            func[DType.uint8]()
        elif self.is_int8():
            func[DType.int8]()
        elif self.is_uint16():
            func[DType.uint16]()
        elif self.is_int16():
            func[DType.int16]()
        elif self.is_uint32():
            func[DType.uint32]()
        elif self.is_int32():
            func[DType.int32]()
        elif self.is_uint64():
            func[DType.uint64.value]()
        elif self.is_int64():
            func[DType.int64]()
        elif self.is_index():
            func[DType.index]()
        else:
            raise Error("only integral types are supported")

    # ===----------------------------------------------------------------------===#
    # dispatch_floating
    # ===----------------------------------------------------------------------===#

    @always_inline
    fn dispatch_floating[
        func: fn[type: DType] () capturing -> None
    ](self) raises:
        """Dispatches a floating-point function corresponding to the current DType.

        Constraints:
            DType must be floating-point or integral.

        Parameters:
            func: A parametrized on dtype function to dispatch.
        """
        if self.is_float16():
            func[DType.float16]()
        # TODO(#15473): Enable after extending LLVM support
        # elif self.is_bfloat16():
        #     func[DType.bfloat16]()
        elif self.is_float32():
            func[DType.float32]()
        elif self.is_float64():
            func[DType.float64]()
        else:
            raise Error("only floating point types are supported")

    @always_inline
    fn _dispatch_bitwidth[
        func: fn[type: DType] () capturing -> None,
    ](self) raises:
        """Dispatches a function corresponding to the current DType's bitwidth.
        This should only be used if func only depends on the bitwidth of the dtype,
        and not other properties of the dtype.

        Parameters:
            func: A parametrized on dtype function to dispatch.
        """
        let bitwidth = self.bitwidth()
        if bitwidth == 8:
            func[DType.uint8]()
        elif bitwidth == 16:
            func[DType.uint16]()
        elif bitwidth == 32:
            func[DType.uint32]()
        elif bitwidth == 64:
            func[DType.uint64]()
        else:
            raise Error(
                "bitwidth_dispatch only supports types with bitwidth [8, 16,"
                " 32, 64]"
            )
        return

    @always_inline
    fn _dispatch_custom[
        func: fn[type: DType] () capturing -> None, *dtypes: DType
    ](self) raises:
        """Dispatches a function corresponding to current DType if it matches
        any type in the dtypes parameter.

        Parameters:
            func: A parametrized on dtype function to dispatch.
            dtypes: A list of DTypes on which to do dispatch.
        """
        alias dtype_var = VariadicList[DType](dtypes)
        var matched = False

        @parameter
        @always_inline
        fn _func[idx: Int]():
            alias dtype = dtype_var[idx]
            if self == dtype:
                matched = True
                return func[dtype]()

        unroll[_func, len(dtype_var)]()

        if not matched:
            raise Error(
                "dispatch_custom: dynamic_type does not match any dtype"
                " parameters"
            )

    # ===----------------------------------------------------------------------===#
    # dispatch_arithmetic
    # ===----------------------------------------------------------------------===#

    @always_inline
    fn dispatch_arithmetic[
        func: fn[type: DType] () capturing -> None
    ](self) raises:
        """Dispatches a function corresponding to the current DType.

        Parameters:
            func: A parametrized on dtype function to dispatch.
        """
        if self.is_floating_point():
            self.dispatch_floating[func]()
        elif self.is_integral():
            self.dispatch_integral[func]()
        else:
            raise Error("only arithmetic types are supported")


# ===-------------------------------------------------------------------===#
# integral_type_of
# ===-------------------------------------------------------------------===#


@always_inline("nodebug")
fn _integral_type_of[type: DType]() -> DType:
    """Gets the integral type which has the same bitwidth as the input type."""

    @parameter
    if type.is_integral():
        return type

    @parameter
    if type == DType.bfloat16 or type == DType.float16:
        return DType.int16

    @parameter
    if type == DType.float32 or type == DType.tensor_float32:
        return DType.int32

    @parameter
    if type == DType.float64:
        return DType.int64

    return type.invalid
