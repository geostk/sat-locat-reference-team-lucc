match_rasters <- function(baseimg, matchimg) {
    require(raster)
    if (projection(baseimg) != projection(matchimg)) {
        message('Coordinate systems do not match - reprojecting matchimg...')
        matchimg <- projectRaster(matchimg, baseimg)
    }
    # First crop out any overlapping area
    message('Cropping matchimg to base...')
    outimg <- crop(matchimg, baseimg)
    # Now extend borders of cropped raster to match base raster
    message('Extending matchimg to base...')
    outimg <- extend(matchimg, outimg)
    #message('Resampling matchimg to base...')
    #resample(outimg, baseimg)
    return(outimg)
}
# library(raster)
# # Mosaic the four ASTER DEM tiles needed to cover the Landsat image
# DEM1 <- raster(system.file('extdata/ASTER_V002_LL.dat', package='LDPKR'))
# DEM2 <- raster(system.file('extdata/ASTER_V002_LR.dat', package='LDPKR'))
# DEM3 <- raster(system.file('extdata/ASTER_V002_UR.dat', package='LDPKR'))
# DEM4 <- raster(system.file('extdata/ASTER_V002_UL.dat', package='LDPKR'))
# DEM_mosaic <- mosaic_imgs(DEM1, list(DEM2, DEM3, DEM4))
# 
# # Crop and extend the DEM mosaic to match the Landsat image
# L5TSR_1986 <- raster(system.file('extdata/L5TSR_1986.dat', package='LDPKR'))
# matched_DEM <- match_rasters(L5TSR_1986, DEM_mosaic)