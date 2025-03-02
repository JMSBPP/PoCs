/*
    verification of sqrt
*/


methods{
    // function mathMastersSqrt(uint256) external returns uint256 envfree;
    // function uniSqrt(uint256) external returns uint256 envfree;
    function topHalfSolmateSqrt(uint256) external returns uint256 envfree;
    function topHalfMathMasterSqrt(uint256 x) external returns uint256 envfree

}



rule topUniSqrtMatchesMathMastersSqrt(uint256 x){
    assert(topHalfSolmateSqrt(x)==topHalfMathMasterSqrt(x));

} 