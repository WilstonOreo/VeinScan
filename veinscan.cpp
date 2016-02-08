

#include <opencv2/imgcodecs.hpp>
#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/core/core.hpp>

#include <iostream>
#include <vector>
#include <array>

typedef uint8_t Pixel;


class VeinScan {
public:
    cv::Mat scan(const cv::Mat& _input) const {
        auto&& _filter = filter();

        using namespace cv;

        size_t _filterSize = _filter.size(); // = 7
        int _k = (_filterSize - 1) / 2;  // = 3

        Mat _output(_input.rows / 2, _input.cols, CV_8U) ;


        /// Apply Histogram Equalization
        Mat _eq(_input,Rect(0,_input.rows/2,_input.cols,_input.rows/2));
        equalizeHist( _eq, _eq );
        Mat _eq2, _eq3;
        GaussianBlur(_eq,_eq2, Size(5,5),0,0);
        medianBlur(_eq2,_eq, 5);
        GaussianBlur(_eq2,_eq,Size(17,17),0,0);

        for( int i = _k; i < _eq.rows- _k; ++i) {
            for( int j = _k; j < _eq.cols -_k; ++j ) {
                auto _inputPix = _eq.template at<Pixel>(i,j );
                auto _inputPix2 = _eq2.template at<Pixel>(i,j );
                _output.template at<Pixel>(i,j) = saturate_cast<Pixel>(128*(_inputPix - _inputPix2)-96) ;
            }
        }
        dilate(_output,_output,Mat(),Point(-1,-1));
        erode(_output,_output,Mat(),Point(-1,-1));
        medianBlur(_output,_eq, 3);
    //    equalizeHist( _output, _output );

        return _eq;
    }

private:
    static std::vector<int> filter() {
        return { 26, 8, -18, -32 , -18, 8, 26};
    }


};




int main(int argc, char* argv[]) {
    std::cout << "Vein Scan!" << std::endl;

    using namespace cv;

    if (argc < 3) {
        std::cout << "Usage: " << std::endl;
        std::cout << "./veinscan <input> <output>" << std::endl;
        return EXIT_FAILURE;
    }

    std::string _input(argv[1]);
    std::string _output(argv[2]);


    std::cout << "Input file: " << _input << std::endl;
    std::cout << "Output file: " << _output << std::endl;

    cv::Mat _inputImage = cv::imread(_input,0);

    VeinScan _veinScan;
    auto _outputImage = _veinScan.scan(_inputImage);

    cv::imwrite(_output,_outputImage);

    return EXIT_SUCCESS;
}
