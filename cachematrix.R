## Put comments here that give an overall description of what your
## functions do

## Write a short comment describing this function
## Return a list of function
## 1. get the value of matrix
## 2. set the value of matrix
## 3. get the value of inverse
## 4. set the value of inverse
makeCacheMatrix <- function(x = matrix()) {
  inv <- NULL
  ##reset the inverse
  set <- function(y){
    x <<- y
    inv <<- NULL
  }
  get <- function()x
  setinv <- function(inver) inv <<- inver
  getinv <- function() inv
  list(set = set, get = get, 
       setinv = setinv,
       getinv = getinv)
}



## Write a short comment describing this function
## Retrieve the inverse if it has been calculated, or calculate the inverse.
cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
  ## if the inverse is calculated, retrieve it
    inv <- x$getinv()
    if(!is.null(inv)){
        message("getting cached data")
        return(inv)
    }
    data <- x$get()
    ## if not exsit, calculate it
    inv <- solve(data,)
    x$setinv(inv)
    inv
}

