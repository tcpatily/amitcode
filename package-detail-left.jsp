<div class="tab-content" id="nav-tabContent">
                                    <div class="tab-pane fade show active" id="nav-itinerary" role="tabpanel"
                                        aria-labelledby="nav-itinerary-tab">
                                        <div class="tab-container tab_itinerary">
                                            <div class="tab-left">
                                                <div class="tabs" >
                                                    <div class="tab-indicator"></div>
                                         <!---<button class="tab-btn active" data-tab="tab1">Day 1</button>
                                                    <button class="tab-btn" data-tab="tab2">Day 2</button>
                                                    <button class="tab-btn" data-tab="tab3">Day 3</button>
                                                    <button class="tab-btn" data-tab="tab4">Day 4</button>
                                                    <button class="tab-btn" data-tab="tab5">Day 5</button>
                                                    <button class="tab-btn" data-tab="tab6">Day 6</button>
                                                    <button class="tab-btn" data-tab="tab7">Day 7</button>
                                                    <button class="tab-btn" data-tab="tab8">Day 8</button>
                                                    <button class="tab-btn" data-tab="tab9">Day 9</button>
                                                    <button class="tab-btn" data-tab="tab10">Day 10</button>
                                                    <button class="tab-btn" data-tab="tab11">Day 11</button>--->
													 <button
            v-for="(day, index) in sortItineraryByDay()"
			
            :key="day.itineraryDay"
            class="tab-btn"
            :class="{ active: index === 0 }"
            :data-tab="'tab' + day.itineraryDay"
          >
            Day {{ day.itineraryDay }}
          </button>
		 
        </div>
                                                </div>
                                               

                                                <div class="tab-right itinerary_details">

  <div 
    :id="'tab' + `${index + 1}`" 
    v-if="sortItineraryByDay()" 
    class="tab-details"  
    v-for="(item, index) in sortItineraryByDay()"
    :key="`${item.itineraryDay}-${index}`">
    
    <div class="accordion">
      <div class="accordion-item">
        <div class="left_blc">
          <h6 class="accordion-header">
            <span class="day_chip">Day {{ item.itineraryDay }}</span>
            {{ item.cityCode.cityName }}
            <span class="wlcm_text" v-if="item.itineraryDay === 1">
              (Welcome to {{ item.cityCode.cityName }}!)
            </span>
          </h6>
        </div>
        <div class="right_arrow">
          <img src="/images/tcHolidays/chevron-down.svg" alt="Toggle" />
        </div>
      </div>

      <div class="accordion-body">
        <div class="content_box">
          
          <!-- Arrival Card -->
          <div class="card_blc">
            <div class="card_top">
              <div class="icon">
                <img src="/images/tcHolidays/tc-PDP/plane.svg" alt="Arrival" />
              </div>
              <span>Arrival in {{ item.cityCode.cityName }}</span>
            </div>
            <span class="sub_title" v-html="item.itineraryDescription"></span>
          </div>

          <!-- Transfer Card -->
          <div class="card_blc">
            <div class="card_top">
              <div class="icon">
                <img src="/images/tcHolidays/tc-PDP/car.svg" alt="Transfer" />
              </div>
              <span>Transfer</span>
            </div>
            <span class="sub_title" v-if="getTransfersByDayAndPackage(item.itineraryDay, selectedPackageClassId)" v-html="getTransfersByDayAndPackage(item.itineraryDay, selectedPackageClassId)?.description"></span>
            <!-- <span class="sub_title" v-else>
              On arrival, our Tour Manager / Local Representative will meet and welcome you outside the airport. 
              Later, we proceed to the hotel and check–in.
            </span> -->
          </div>

          <!-- Sightseeing Card -->
          <div class="card_blc" v-if="getSightSeeingByDayAndPackage(item.itineraryDay, selectedPackageClassId)">
            <div class="card_top">
              <div class="icon">
                <img src="/images/tcHolidays/tc-PDP/camera-01.svg" alt="Sightseeing" />
              </div>
              <p>Sightseeing</p>
            </div>
            <div class="sight_blc" v-for="(image, index) in getSightSeeingByDayAndPackage(item.itineraryDay,selectedPackageClassId)?.sightseeingId?.tcilMstSightseeingImagesCollection" :key="index">
             
              <div class="sight_item">
                <div class="sight_left">
                  <img :src="handleImagePath(image?.imagePath)" alt="Sightseeing" />
                </div>
                <div class="sight_right">
                  <p v-html="getSightSeeingByDayAndPackage(item.itineraryDay,selectedPackageClassId)?.sightseeingId?.name || ''"></p>
                  <span v-html="getSightSeeingByDayAndPackage(item.itineraryDay, selectedPackageClassId)?.sightseeingId?.description || 'No description available'"></span>
                </div>
              </div>
            </div>
          </div>


           <div class="card_blc" v-if="getHotelsByDayAndPackage(item.itineraryDay, selectedPackageClassId)">
    <div class="card_top">
      <div class="icon">
        <img src="/images/tcHolidays/tc-PDP/hotels.svg" alt="Hotels Icon" />
      </div>
      <p>Hotels</p>
    </div>

    <div class="hotelCard_slide owl-carousel">
      <div class="card_item" v-for="(hotel, index) in getHotelsByDayAndPackage(item.itineraryDay, selectedPackageClassId)" :key="index">
        <div class="crb_lft">
          <img :src="getHotelImage(hotel)" :alt="hotel.accomodationHotelId.hotelName" />
        </div>
        <div class="crb_right">
          <span class="sub_title">
            {{ hotel.accomodationHotelId.hotelName }}
          </span>
          <div class="rating">
            <span class="stars">
              <img src="/images/tcHolidays/star.svg" alt="star" />
            </span>
            <span>
              <b>{{ hotel.accomodationHotelId.starRating }}</b>(1.5K)
            </span>
          </div>
        </div>
      </div>
    </div>

    <div class="short_note">
      <span>Note:</span> The above mentioned hotels will be same or similar
    </div>
  </div>


          <!-- Hotels Card -->
          <!-- <div class="card_blc">
            <div class="card_top">
              <div class="icon">
                <img src="/images/tcHolidays/tc-PDP/hotels.svg" alt="Hotels" />
              </div>
              <span>Hotels</span>
            </div> -->
            
            <!-- Overnight Stay Info -->
            <!-- <div class="overnight_info" v-if="item.overnightStay">
              <span class="sub_title" v-html="item.overnightStay"></span>
            </div> -->

            <!-- Hotel Carousel - You can populate this dynamically if you have hotel array data -->
            <!-- <div class="hotelCard_slide owl-carousel" v-if="false">
              <div class="card_item">
                <div class="crb_lft">
                  <img src="/images/tcHolidays/tc-PDP/building.svg" alt="Hotel" />
                </div>
                <div class="crb_right">
                  <span class="sub_title">Hotel Name</span>
                  <div class="rating">
                    <span class="stars">
                      <img src="/images/tcHolidays/star.svg" alt="Star" />
                    </span>
                    <span><b>4.5</b>(1.5K)</span>
                  </div>
                </div>
              </div>
            </div> -->

            <!-- <div class="short_note">
              <span>Note:</span> The above mentioned hotels will be same or similar
            </div>
          </div> -->

          <!-- Meal Card -->
          <div class="card_blc">
            <div class="card_top">
              <div class="icon">
                <img src="/images/tcHolidays/tc-PDP/meal.svg" alt="Meals" />
              </div>
              <span>Meal</span>
            </div>
            <span class="sub_title">{{ getMealText(item.itineraryDay, selectedPackageClassId) }}</span>
          </div>

          <!-- Optional Activities -->
          <div class="card_blc" v-if="item.tcilHolidayItineraryOptionalsCollection && item.tcilHolidayItineraryOptionalsCollection.length > 0">
            <div class="card_top">
              <div class="icon">
                <img src="/images/tcHolidays/tc-PDP/activity.svg" alt="Activities" />
              </div>
              <span>Optional Activities</span>
            </div>
            <div v-for="(optional, oIndex) in item.tcilHolidayItineraryOptionalsCollection" :key="oIndex" class="optional_item">
              <span class="sub_title" v-html="optional.description"></span>
            </div>
          </div>

          <!-- Note Block -->
          <div class="note_blc">
            <span>
              <span>Note:</span> Joining direct passenger / NRI can check-in on your own at the hotel. 
              The standard check-in time is 1500 hrs. We may have to proceed directly for dinner or 
              packed dinner will be provided in case of late arrivals of flight or long queue at the immigration.
            </span>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
                                            
                                            <!-- <div class="tab-right itinerary_details">
                                                <div id="tab1" class="tab-details">
                                                    <div class="accordion">
                                                        <div class="accordion-item">
                                                            <div class="left_blc">
                                                                <h6 class="accordion-header">
                                                                    <span class="day_chip">Day 1</span>Paris
                                                                    <span class="wlcm_text">(Welcome to Paris!)</span>
                                                                </h6>
                                                            </div>
                                                            <div class="right_arrow">
                                                                <img src="/images/tcHolidays/chevron-down.svg"
                                                                    alt="" />
                                                            </div>
                                                        </div>

                                                        <div class="accordion-body">
                                                            <div class="content_box">
                                                                <div class="card_blc">
                                                                    <div class="card_top">
                                                                        <div class="icon">
                                                                            <img src="/images/tcHolidays/tc-PDP/plane.svg"
                                                                                alt="" />
                                                                        </div>
                                                                        <p>Arrival in Paris</p>
                                                                    </div>
                                                                    <span class="sub_title">Return economy flight
                                                                        included subject to user selection</span>
                                                                </div>
                                                                <div class="card_blc">
                                                                    <div class="card_top">
                                                                        <div class="icon">
                                                                            <img src="/images/tcHolidays/tc-PDP/car.svg"
                                                                                alt="" />
                                                                        </div>
                                                                        <p>Transfer</p>
                                                                    </div>
                                                                    <span class="sub_title">
                                                                        On arrival, our Tour Manager / Local
                                                                        Representative will meet and welcome you outside
                                                                        the airport. Later, we proceed to the hotel and
                                                                        check–in.
                                                                    </span>
                                                                </div>
                                                                <div class="card_blc">
                                                                    <div class="card_top">
                                                                        <div class="icon">
                                                                            <img src="/images/tcHolidays/tc-PDP/hotels.svg"
                                                                                alt="" />
                                                                        </div>
                                                                        <p>Hotels</p>
                                                                    </div>
                                                                    <div class="hotelCard_slide owl-carousel">
                                                                        <div class="card_item">
                                                                            <div class="crb_lft">
                                                                                <img src="/images/tcHolidays/tc-PDP/building.svg"
                                                                                    alt="" />
                                                                            </div>
                                                                            <div class="crb_right">
                                                                                <span class="sub_title">Moxy CDG / Ibis
                                                                                    Styles CDG</span>
                                                                                <div class="rating">
                                                                                    <span class="stars">
                                                                                        <img src="/images/tcHolidays/star.svg"
                                                                                            alt="" />
                                                                                    </span>
                                                                                    <span><b>4.5</b>(1.5K)</span>
                                                                                </div>
                                                                            </div>
                                                                        </div>

                                                                        <div class="card_item">
                                                                            <div class="crb_lft">
                                                                                <img src="/images/tcHolidays/tc-PDP/hotel-building-02.png"
                                                                                    alt="" />
                                                                            </div>
                                                                            <div class="crb_right">
                                                                                <span class="sub_title">Moxy CDG / Ibis
                                                                                    Styles CDG</span>
                                                                                <div class="rating">
                                                                                    <span class="stars">
                                                                                        <img src="/images/tcHolidays/star.svg"
                                                                                            alt="" />
                                                                                    </span>
                                                                                    <span><b>4.7</b>(1.8K)</span>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="short_note"><span>Note:</span> The above
                                                                        mentioned hotels will be same or similar</div>
                                                                </div>
                                                                <div class="card_blc">
                                                                    <div class="card_top">
                                                                        <div class="icon">
                                                                            <img src="/images/tcHolidays/tc-PDP/meal.svg"
                                                                                alt="" />
                                                                        </div>
                                                                        <p>Meal</p>
                                                                    </div>
                                                                    <span class="sub_title">Dinner</span>
                                                                </div>
                                                                <div class="note_blc">
                                                                    <span>
                                                                        <span>Note:</span> Joining direct passenger /
                                                                        NRI can check-in on your own at the hotel. The
                                                                        standard check-in time is 1500 hrs. We may have
                                                                        to proceed directly for
                                                                        dinner or packed dinner will be provided in case
                                                                        of late arrivals of flight or long queue at the
                                                                        immigration.
                                                                    </span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div id="tab2" class="tab-details">
                                                    <div class="accordion">
                                                        <div class="accordion-item">
                                                            <div class="left_blc">
                                                                <h6 class="accordion-header"><span class="day_chip">Day
                                                                        2</span>Paris</h6>
                                                            </div>
                                                            <div class="right_arrow">
                                                                <img src="/images/tcHolidays/chevron-down.svg"
                                                                    alt="" />
                                                            </div>
                                                        </div>
                                                        <div class="accordion-body">
                                                            <div class="content_box">
                                                                <div class="card_blc">
                                                                    <div class="card_top">
                                                                        <div class="icon">
                                                                            <img src="/images/tcHolidays/tc-PDP/hotels.svg"
                                                                                alt="" />
                                                                        </div>
                                                                        <p>Hotels</p>
                                                                    </div>
                                                                    <div class="hotelCard_slide owl-carousel">
                                                                        <div class="card_item">
                                                                            <div class="crb_lft">
                                                                                <img src="/images/tcHolidays/tc-PDP/building.svg"
                                                                                    alt="" />
                                                                            </div>
                                                                            <div class="crb_right">
                                                                                <span class="sub_title">Moxy CDG / Ibis
                                                                                    Styles CDG</span>
                                                                                <div class="rating">
                                                                                    <span class="stars">
                                                                                        <img src="/images/tcHolidays/star.svg"
                                                                                            alt="" />
                                                                                    </span>
                                                                                    <span><b>4.5</b>(1.5K)</span>
                                                                                </div>
                                                                            </div>
                                                                        </div>

                                                                        <div class="card_item">
                                                                            <div class="crb_lft">
                                                                                <img src="/images/tcHolidays/tc-PDP/hotel-building-02.png"
                                                                                    alt="" />
                                                                            </div>
                                                                            <div class="crb_right">
                                                                                <span class="sub_title">Moxy CDG / Ibis
                                                                                    Styles CDG</span>
                                                                                <div class="rating">
                                                                                    <span class="stars">
                                                                                        <img src="/images/tcHolidays/star.svg"
                                                                                            alt="" />
                                                                                    </span>
                                                                                    <span><b>4.7</b>(1.8K)</span>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="short_note"><span>Note:</span> The above
                                                                        mentioned hotels will be same or similar</div>
                                                                </div>
                                                                <div class="card_blc">
                                                                    <div class="card_top">
                                                                        <div class="icon">
                                                                            <img src="/images/tcHolidays/tc-PDP/camera-01.svg"
                                                                                alt="" />
                                                                        </div>
                                                                        <p>Sightseeing</p>
                                                                    </div>
                                                                    <div class="sight_blc">
                                                                        <div class="sight_item">
                                                                            <div class="sight_left">
                                                                                <img src="/images/tcHolidays/tc-PDP/sight-01.png"
                                                                                    alt="" />
                                                                            </div>
                                                                            <div class="sight_right">
                                                                                <p>Guided City Tour of Paris</p>
                                                                                <span>Explore iconic landmarks like
                                                                                    Alexander Bridge, Arc de Triomphe,
                                                                                    Concorde Square, Opera House, and
                                                                                    Les Invalides.</span>
                                                                            </div>
                                                                        </div>

                                                                        <div class="sight_item">
                                                                            <div class="sight_left">
                                                                                <img src="/images/tcHolidays/tc-PDP/sight-02.png"
                                                                                    alt="" />
                                                                            </div>
                                                                            <div class="sight_right">
                                                                                <p>Visit Fragonard - French Perfume
                                                                                    Museum</p>
                                                                                <span>Discover the art of French
                                                                                    perfumery and explore exquisite
                                                                                    fragrances at this historic
                                                                                    museum.</span>
                                                                            </div>
                                                                        </div>

                                                                        <div class="sight_item">
                                                                            <div class="sight_left">
                                                                                <img src="/images/tcHolidays/tc-PDP/sight-03.png"
                                                                                    alt="" />
                                                                            </div>
                                                                            <div class="sight_right">
                                                                                <p>Guided Tour of Versailles Palace</p>
                                                                                <span>Walk through the grand private
                                                                                    apartments, Opera Hall, the Chapel,
                                                                                    and the stunning Hall of
                                                                                    Mirrors.</span>
                                                                            </div>
                                                                        </div>

                                                                        <div class="sight_item">
                                                                            <div class="sight_left">
                                                                                <img src="/images/tcHolidays/tc-PDP/sight-04.png"
                                                                                    alt="" />
                                                                            </div>
                                                                            <div class="sight_right">
                                                                                <p>Scenic River Seine Cruise</p>
                                                                                <span>Enjoy breathtaking views of Paris
                                                                                    as you sail along the iconic River
                                                                                    Seine.</span>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="card_blc">
                                                                    <div class="card_top">
                                                                        <div class="icon">
                                                                            <img src="/images/tcHolidays/tc-PDP/meal.svg"
                                                                                alt="" />
                                                                        </div>
                                                                        <p>Meal</p>
                                                                    </div>
                                                                    <span class="sub_title">Breakfast, Lunch and
                                                                        Dinner</span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div id="tab3" class="tab-details">
                                                    <div class="accordion">
                                                        <div class="accordion-item">
                                                            <div class="left_blc">
                                                                <h6 class="accordion-header"><span class="day_chip">Day
                                                                        3</span>Paris</h6>
                                                            </div>
                                                            <div class="right_arrow">
                                                                <img src="/images/tcHolidays/chevron-down.svg"
                                                                    alt="" />
                                                            </div>
                                                        </div>
                                                        <div class="accordion-body">
                                                            <div class="content_box">
                                                                <div class="card_blc">
                                                                    <div class="card_top">
                                                                        <div class="icon">
                                                                            <img src="/images/tcHolidays/tc-PDP/hotels.svg"
                                                                                alt="" />
                                                                        </div>
                                                                        <p>Hotels</p>
                                                                    </div>
                                                                    <div class="hotelCard_slide owl-carousel">
                                                                        <div class="card_item">
                                                                            <div class="crb_lft">
                                                                                <img src="/images/tcHolidays/tc-PDP/building.svg"
                                                                                    alt="" />
                                                                            </div>
                                                                            <div class="crb_right">
                                                                                <span class="sub_title">Moxy CDG / Ibis
                                                                                    Styles CDG</span>
                                                                                <div class="rating">
                                                                                    <span class="stars">
                                                                                        <img src="/images/tcHolidays/star.svg"
                                                                                            alt="" />
                                                                                    </span>
                                                                                    <span><b>4.5</b>(1.5K)</span>
                                                                                </div>
                                                                            </div>
                                                                        </div>

                                                                        <div class="card_item">
                                                                            <div class="crb_lft">
                                                                                <img src="/images/tcHolidays/tc-PDP/hotel-building-02.png"
                                                                                    alt="" />
                                                                            </div>
                                                                            <div class="crb_right">
                                                                                <span class="sub_title">Moxy CDG / Ibis
                                                                                    Styles CDG</span>
                                                                                <div class="rating">
                                                                                    <span class="stars">
                                                                                        <img src="/images/tcHolidays/star.svg"
                                                                                            alt="" />
                                                                                    </span>
                                                                                    <span><b>4.7</b>(1.8K)</span>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="short_note"><span>Note:</span> The above
                                                                        mentioned hotels will be same or similar</div>
                                                                </div>
                                                                <div class="card_blc">
                                                                    <div class="card_top">
                                                                        <div class="icon">
                                                                            <img src="/images/tcHolidays/tc-PDP/camera-01.svg"
                                                                                alt="" />
                                                                        </div>
                                                                        <p>Sightseeing</p>
                                                                    </div>
                                                                    <div class="sight_blc">
                                                                        <div class="sight_item">
                                                                            <div class="sight_left">
                                                                                <img src="/images/tcHolidays/tc-PDP/sight-05.png"
                                                                                    alt="" />
                                                                            </div>
                                                                            <div class="sight_right">
                                                                                <p>Disneyland® Paris (1 Day, 1 Park)</p>
                                                                                <ul>
                                                                                    <li>Spend up to 5 hours exploring
                                                                                        either Disneyland® Park or Walt
                                                                                        Disney Studios®.</li>
                                                                                    <li>
                                                                                        Experience thrilling
                                                                                        rollercoasters, meet your
                                                                                        favorite characters like Alice
                                                                                        in Wonderland & Pinocchio, and
                                                                                        explore magical lands like
                                                                                        Fantasyland
                                                                                        & Adventureland.
                                                                                    </li>
                                                                                </ul>
                                                                            </div>
                                                                        </div>

                                                                        <div class="sight_item">
                                                                            <div class="sight_left">
                                                                                <img src="/images/tcHolidays/tc-PDP/sight-01.png"
                                                                                    alt="" />
                                                                            </div>
                                                                            <div class="sight_right">
                                                                                <p>Eiffel Tower – 2nd Level</p>
                                                                                <span>Enjoy breathtaking panoramic views
                                                                                    of Paris from the iconic 2nd level
                                                                                    of the Eiffel Tower.</span>
                                                                            </div>
                                                                        </div>

                                                                        <div class="sight_item">
                                                                            <div class="sight_left">
                                                                                <img src="/images/tcHolidays/tc-PDP/sight-06.png"
                                                                                    alt="" />
                                                                            </div>
                                                                            <div class="sight_right">
                                                                                <p>Paris Illumination Tour</p>
                                                                                <ul>
                                                                                    <li>Witness the magic of Paris by
                                                                                        night as famous landmarks light
                                                                                        up, creating a mesmerizing
                                                                                        cityscape.</li>
                                                                                    <li>Overnight Stay in Paris (CDG
                                                                                        Area), France.</li>
                                                                                </ul>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="card_blc">
                                                                    <div class="card_top">
                                                                        <div class="icon">
                                                                            <img src="/images/tcHolidays/tc-PDP/meal.svg"
                                                                                alt="" />
                                                                        </div>
                                                                        <p>Meal</p>
                                                                    </div>
                                                                    <span class="sub_title">Breakfast, Lunch and
                                                                        Dinner</span>
                                                                </div>
                                                                <div class="note_blc">
                                                                    <span><span>Note:</span>Due to stringent security
                                                                        checks at the Eiffel Tower, it may take up to 4
                                                                        – 5 hours in the queue.</span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div id="tab4" class="tab-details">
                                                    <div class="accordion">
                                                        <div class="accordion-item">
                                                            <div class="left_blc">
                                                                <h6 class="accordion-header"><span class="day_chip">Day
                                                                        4</span>Switzerland</h6>
                                                            </div>
                                                            <div class="right_arrow">
                                                                <img src="/images/tcHolidays/chevron-down.svg"
                                                                    alt="" />
                                                            </div>
                                                        </div>
                                                        <div class="accordion-body">
                                                            <div class="content_box">
                                                                <div class="card_blc">
                                                                    <div class="card_top">
                                                                        <div class="icon">
                                                                            <img src="/images/tcHolidays/tc-PDP/arrow-narrow-down-right.svg"
                                                                                alt="" />
                                                                        </div>
                                                                        <p>Arrival in Switzerland</p>
                                                                    </div>
                                                                    <span class="sub_title">Upon arrival in Switzerland,
                                                                        proceed to your hotel and complete the check-in
                                                                        formalities.</span>
                                                                </div>
                                                                <div class="card_blc">
                                                                    <div class="card_top">
                                                                        <div class="icon">
                                                                            <img src="/images/tcHolidays/tc-PDP/hotels.svg"
                                                                                alt="" />
                                                                        </div>
                                                                        <p>Hotels</p>
                                                                    </div>
                                                                    <div class="hotelCard_slide owl-carousel">
                                                                        <div class="card_item">
                                                                            <div class="crb_lft">
                                                                                <img src="/images/tcHolidays/tc-PDP/building.svg"
                                                                                    alt="" />
                                                                            </div>
                                                                            <div class="crb_right">
                                                                                <span class="sub_title">Moxy CDG / Ibis
                                                                                    Styles CDG</span>
                                                                                <div class="rating">
                                                                                    <span class="stars">
                                                                                        <img src="/images/tcHolidays/star.svg"
                                                                                            alt="" />
                                                                                    </span>
                                                                                    <span><b>4.5</b>(1.5K)</span>
                                                                                </div>
                                                                            </div>
                                                                        </div>

                                                                        <div class="card_item">
                                                                            <div class="crb_lft">
                                                                                <img src="/images/tcHolidays/tc-PDP/hotel-building-02.png"
                                                                                    alt="" />
                                                                            </div>
                                                                            <div class="crb_right">
                                                                                <span class="sub_title">Moxy CDG / Ibis
                                                                                    Styles CDG</span>
                                                                                <div class="rating">
                                                                                    <span class="stars">
                                                                                        <img src="/images/tcHolidays/star.svg"
                                                                                            alt="" />
                                                                                    </span>
                                                                                    <span><b>4.7</b>(1.8K)</span>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="short_note"><span>Note:</span> The above
                                                                        mentioned hotels will be same or similar</div>
                                                                </div>
                                                                <div class="card_blc">
                                                                    <div class="card_top">
                                                                        <div class="icon">
                                                                            <img src="/images/tcHolidays/tc-PDP/camera-01.svg"
                                                                                alt="" />
                                                                        </div>
                                                                        <p>Sightseeing</p>
                                                                    </div>
                                                                    <div class="sight_blc">
                                                                        <div class="sight_item">
                                                                            <div class="sight_left">
                                                                                <img src="/images/tcHolidays/tc-PDP/sight-05.png"
                                                                                    alt="" />
                                                                            </div>
                                                                            <div class="sight_right">
                                                                                <p>Scenic Drive to Switzerland</p>
                                                                                <span>Enjoy a picturesque journey
                                                                                    through charming European landscapes
                                                                                    as you head towards
                                                                                    Switzerland.</span>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="card_blc">
                                                                    <div class="card_top">
                                                                        <div class="icon">
                                                                            <img src="/images/tcHolidays/tc-PDP/meal.svg"
                                                                                alt="" />
                                                                        </div>
                                                                        <p>Meal</p>
                                                                    </div>
                                                                    <span class="sub_title">Breakfast, Lunch and
                                                                        Dinner</span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div id="tab5" class="tab-details">
                                                    <div class="accordion">
                                                        <div class="accordion-item">
                                                            <div class="left_blc">
                                                                <h6 class="accordion-header"><span class="day_chip">Day
                                                                        5</span>Switzerland</h6>
                                                            </div>
                                                            <div class="right_arrow">
                                                                <img src="/images/tcHolidays/chevron-down.svg"
                                                                    alt="" />
                                                            </div>
                                                        </div>
                                                        <div class="accordion-body">
                                                            <div class="content_box">
                                                                <div class="card_blc">
                                                                    <div class="card_top">
                                                                        <div class="icon">
                                                                            <img src="/images/tcHolidays/tc-PDP/arrow-narrow-down-right.svg"
                                                                                alt="" />
                                                                        </div>
                                                                        <p>Arrival in Switzerland</p>
                                                                    </div>
                                                                    <span class="sub_title">Upon arrival in Switzerland,
                                                                        proceed to your hotel and complete the check-in
                                                                        formalities.</span>
                                                                </div>
                                                                <div class="card_blc">
                                                                    <div class="card_top">
                                                                        <div class="icon">
                                                                            <img src="/images/tcHolidays/tc-PDP/hotels.svg"
                                                                                alt="" />
                                                                        </div>
                                                                        <p>Hotels</p>
                                                                    </div>
                                                                    <div class="hotelCard_slide owl-carousel">
                                                                        <div class="card_item">
                                                                            <div class="crb_lft">
                                                                                <img src="/images/tcHolidays/tc-PDP/building.svg"
                                                                                    alt="" />
                                                                            </div>
                                                                            <div class="crb_right">
                                                                                <span class="sub_title">Moxy CDG / Ibis
                                                                                    Styles CDG</span>
                                                                                <div class="rating">
                                                                                    <span class="stars">
                                                                                        <img src="/images/tcHolidays/star.svg"
                                                                                            alt="" />
                                                                                    </span>
                                                                                    <span><b>4.5</b>(1.5K)</span>
                                                                                </div>
                                                                            </div>
                                                                        </div>

                                                                        <div class="card_item">
                                                                            <div class="crb_lft">
                                                                                <img src="/images/tcHolidays/tc-PDP/hotel-building-02.png"
                                                                                    alt="" />
                                                                            </div>
                                                                            <div class="crb_right">
                                                                                <span class="sub_title">Moxy CDG / Ibis
                                                                                    Styles CDG</span>
                                                                                <div class="rating">
                                                                                    <span class="stars">
                                                                                        <img src="/images/tcHolidays/star.svg"
                                                                                            alt="" />
                                                                                    </span>
                                                                                    <span><b>4.7</b>(1.8K)</span>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="short_note"><span>Note:</span> The above
                                                                        mentioned hotels will be same or similar</div>
                                                                </div>
                                                                <div class="card_blc">
                                                                    <div class="card_top">
                                                                        <div class="icon">
                                                                            <img src="/images/tcHolidays/tc-PDP/camera-01.svg"
                                                                                alt="" />
                                                                        </div>
                                                                        <p>Sightseeing</p>
                                                                    </div>
                                                                    <div class="sight_blc">
                                                                        <div class="sight_item">
                                                                            <div class="sight_left">
                                                                                <img src="/images/tcHolidays/tc-PDP/sight-07.png"
                                                                                    alt="" />
                                                                            </div>
                                                                            <div class="sight_right">
                                                                                <p>Day at Leisure (Default Plan)</p>
                                                                                <span>Spend the day relaxing or
                                                                                    exploring Switzerland at your own
                                                                                    pace.</span>
                                                                            </div>
                                                                        </div>
                                                                        <div class="sight_item">
                                                                            <div class="sight_left">
                                                                                <img src="/images/tcHolidays/tc-PDP/sight-08.png"
                                                                                    alt="" />
                                                                            </div>
                                                                            <div class="sight_right">
                                                                                <p>Jungfraujoch & Interlaken (Optional)
                                                                                </p>
                                                                                <ul>
                                                                                    <li>
                                                                                        Experience the thrill of
                                                                                        ascending to Jungfraujoch – Top
                                                                                        of Europe, by cable car and
                                                                                        cog-wheel train, reaching
                                                                                        Europe’s highest railway station
                                                                                        at
                                                                                        3,454 meters.
                                                                                    </li>
                                                                                    <li>Discover the magical Ice Palace
                                                                                        and take in panoramic views from
                                                                                        the Sphinx Observatory Deck,
                                                                                        overlooking the longest glacier
                                                                                        in the Alps.</li>
                                                                                    <li>Later, explore the picturesque
                                                                                        town of Interlaken, nestled
                                                                                        between Lake Thun and Lake
                                                                                        Brienz, surrounded by
                                                                                        snow-capped peaks.</li>
                                                                                </ul>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="card_blc">
                                                                    <div class="card_top">
                                                                        <div class="icon">
                                                                            <img src="/images/tcHolidays/tc-PDP/meal.svg"
                                                                                alt="" />
                                                                        </div>
                                                                        <p>Meal</p>
                                                                    </div>
                                                                    <span class="sub_title">Breakfast, Lunch and
                                                                        Dinner</span>
                                                                </div>
                                                                <div class="note_blc">
                                                                    <span><span>Note:</span> Due to stringent security
                                                                        checks at the Eiffel Tower, it may take up to 4
                                                                        – 5 hours in the queue.</span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div id="tab6" class="tab-details">
                                                    <div class="accordion">
                                                        <div class="accordion-item">
                                                            <div class="left_blc">
                                                                <h6 class="accordion-header"><span class="day_chip">Day
                                                                        6</span>Switzerland</h6>
                                                            </div>
                                                            <div class="right_arrow">
                                                                <img src="/images/tcHolidays/chevron-down.svg"
                                                                    alt="" />
                                                            </div>
                                                        </div>
                                                        <div class="accordion-body">
                                                            <div class="content_box">
                                                                <div class="card_blc">
                                                                    <div class="card_top">
                                                                        <div class="icon">
                                                                            <img src="/images/tcHolidays/tc-PDP/arrow-narrow-down-right.svg"
                                                                                alt="" />
                                                                        </div>
                                                                        <p>Arrival in Switzerland</p>
                                                                    </div>
                                                                    <span class="sub_title">Upon arrival in Switzerland,
                                                                        proceed to your hotel and complete the check-in
                                                                        formalities.</span>
                                                                </div>
                                                                <div class="card_blc">
                                                                    <div class="card_top">
                                                                        <div class="icon">
                                                                            <img src="/images/tcHolidays/tc-PDP/hotels.svg"
                                                                                alt="" />
                                                                        </div>
                                                                        <p>Hotels</p>
                                                                    </div>
                                                                    <div class="hotelCard_slide owl-carousel">
                                                                        <div class="card_item">
                                                                            <div class="crb_lft">
                                                                                <img src="/images/tcHolidays/tc-PDP/building.svg"
                                                                                    alt="" />
                                                                            </div>
                                                                            <div class="crb_right">
                                                                                <span class="sub_title">Moxy CDG / Ibis
                                                                                    Styles CDG</span>
                                                                                <div class="rating">
                                                                                    <span class="stars">
                                                                                        <img src="/images/tcHolidays/star.svg"
                                                                                            alt="" />
                                                                                    </span>
                                                                                    <span><b>4.5</b>(1.5K)</span>
                                                                                </div>
                                                                            </div>
                                                                        </div>

                                                                        <div class="card_item">
                                                                            <div class="crb_lft">
                                                                                <img src="/images/tcHolidays/tc-PDP/hotel-building-02.png"
                                                                                    alt="" />
                                                                            </div>
                                                                            <div class="crb_right">
                                                                                <span class="sub_title">Moxy CDG / Ibis
                                                                                    Styles CDG</span>
                                                                                <div class="rating">
                                                                                    <span class="stars">
                                                                                        <img src="/images/tcHolidays/star.svg"
                                                                                            alt="" />
                                                                                    </span>
                                                                                    <span><b>4.7</b>(1.8K)</span>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="short_note"><span>Note:</span> The above
                                                                        mentioned hotels will be same or similar</div>
                                                                </div>
                                                                <div class="card_blc">
                                                                    <div class="card_top">
                                                                        <div class="icon">
                                                                            <img src="/images/tcHolidays/tc-PDP/camera-01.svg"
                                                                                alt="" />
                                                                        </div>
                                                                        <p>Sightseeing</p>
                                                                    </div>
                                                                    <div class="sight_blc">
                                                                        <div class="sight_item">
                                                                            <div class="sight_left">
                                                                                <img src="/images/tcHolidays/tc-PDP/sight-09.png"
                                                                                    alt="" />
                                                                            </div>
                                                                            <div class="sight_right">
                                                                                <p>Orientation Tour of Lucerne</p>
                                                                                <ul>
                                                                                    <li>Discover the charming city of
                                                                                        Lucerne with highlights like the
                                                                                        Lion Monument and the
                                                                                        Kapellbrücke (Chapel Bridge).
                                                                                    </li>
                                                                                    <li>Enjoy free time to stroll
                                                                                        around, shop for authentic Swiss
                                                                                        watches, knives, chocolates, and
                                                                                        unique souvenirs.</li>
                                                                                </ul>
                                                                            </div>
                                                                        </div>
                                                                        <div class="sight_item">
                                                                            <div class="sight_left">
                                                                                <img src="/images/tcHolidays/tc-PDP/sight-10.png"
                                                                                    alt="" />
                                                                            </div>
                                                                            <div class="sight_right">
                                                                                <p>Visit Mt. Titlis</p>
                                                                                <ul>
                                                                                    <li>Ascend to the summit of Mt.
                                                                                        Titlis (3,020 meters) via
                                                                                        multiple cable cars, including
                                                                                        the Rotair – the world’s first
                                                                                        rotating cable car.</li>
                                                                                    <li>Experience the thrilling Cliff
                                                                                        Walk, a suspension bridge
                                                                                        offering breathtaking views
                                                                                        along the edge of the mountain.
                                                                                    </li>
                                                                                </ul>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="card_blc">
                                                                    <div class="card_top">
                                                                        <div class="icon">
                                                                            <img src="/images/tcHolidays/tc-PDP/meal.svg"
                                                                                alt="" />
                                                                        </div>
                                                                        <p>Meal</p>
                                                                    </div>
                                                                    <span class="sub_title">Breakfast, Lunch and
                                                                        Dinner</span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div id="tab7" class="tab-details">
                                                    <div class="accordion">
                                                        <div class="accordion-item">
                                                            <div class="left_blc">
                                                                <h6 class="accordion-header"><span class="day_chip">Day
                                                                        7</span>Italy</h6>
                                                            </div>
                                                            <div class="right_arrow">
                                                                <img src="/images/tcHolidays/chevron-down.svg"
                                                                    alt="" />
                                                            </div>
                                                        </div>
                                                        <div class="accordion-body">
                                                            <div class="content_box">
                                                                <div class="card_blc">
                                                                    <div class="card_top">
                                                                        <div class="icon">
                                                                            <img src="/images/tcHolidays/tc-PDP/arrow-narrow-down-right.svg"
                                                                                alt="" />
                                                                        </div>
                                                                        <p>Arrival in Italy</p>
                                                                    </div>
                                                                    <span class="sub_title">Upon arrival in Italy,
                                                                        proceed to your hotel and complete the check-in
                                                                        formalities.</span>
                                                                </div>
                                                                <div class="card_blc">
                                                                    <div class="card_top">
                                                                        <div class="icon">
                                                                            <img src="/images/tcHolidays/tc-PDP/hotels.svg"
                                                                                alt="" />
                                                                        </div>
                                                                        <p>Hotels</p>
                                                                    </div>
                                                                    <div class="hotelCard_slide owl-carousel">
                                                                        <div class="card_item">
                                                                            <div class="crb_lft">
                                                                                <img src="/images/tcHolidays/tc-PDP/building.svg"
                                                                                    alt="" />
                                                                            </div>
                                                                            <div class="crb_right">
                                                                                <span class="sub_title">Moxy CDG / Ibis
                                                                                    Styles CDG</span>
                                                                                <div class="rating">
                                                                                    <span class="stars">
                                                                                        <img src="/images/tcHolidays/star.svg"
                                                                                            alt="" />
                                                                                    </span>
                                                                                    <span><b>4.5</b>(1.5K)</span>
                                                                                </div>
                                                                            </div>
                                                                        </div>

                                                                        <div class="card_item">
                                                                            <div class="crb_lft">
                                                                                <img src="/images/tcHolidays/tc-PDP/hotel-building-02.png"
                                                                                    alt="" />
                                                                            </div>
                                                                            <div class="crb_right">
                                                                                <span class="sub_title">Moxy CDG / Ibis
                                                                                    Styles CDG</span>
                                                                                <div class="rating">
                                                                                    <span class="stars">
                                                                                        <img src="/images/tcHolidays/star.svg"
                                                                                            alt="" />
                                                                                    </span>
                                                                                    <span><b>4.7</b>(1.8K)</span>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="short_note"><span>Note:</span> The above
                                                                        mentioned hotels will be same or similar</div>
                                                                </div>
                                                                <div class="card_blc">
                                                                    <div class="card_top">
                                                                        <div class="icon">
                                                                            <img src="/images/tcHolidays/tc-PDP/camera-01.svg"
                                                                                alt="" />
                                                                        </div>
                                                                        <p>Sightseeing</p>
                                                                    </div>
                                                                    <div class="sight_blc">
                                                                        <div class="sight_item">
                                                                            <div class="sight_left">
                                                                                <img src="/images/tcHolidays/tc-PDP/sight-11.png"
                                                                                    alt="" />
                                                                            </div>
                                                                            <div class="sight_right">
                                                                                <p>Orientation Tour of Lucerne</p>
                                                                                <ul>
                                                                                    <li>Discover the charming city of
                                                                                        Lucerne with highlights like the
                                                                                        Lion Monument and the
                                                                                        Kapellbrücke (Chapel Bridge).
                                                                                    </li>
                                                                                    <li>Enjoy free time to stroll
                                                                                        around, shop for authentic Swiss
                                                                                        watches, knives, chocolates, and
                                                                                        unique souvenirs.</li>
                                                                                </ul>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="card_blc">
                                                                    <div class="card_top">
                                                                        <div class="icon">
                                                                            <img src="/images/tcHolidays/tc-PDP/meal.svg"
                                                                                alt="" />
                                                                        </div>
                                                                        <p>Meal</p>
                                                                    </div>
                                                                    <span class="sub_title">Breakfast, Lunch and
                                                                        Dinner</span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div id="tab8" class="tab-details">
                                                    <div class="accordion">
                                                        <div class="accordion-item">
                                                            <div class="left_blc">
                                                                <h6 class="accordion-header"><span class="day_chip">Day
                                                                        8</span>Italy</h6>
                                                            </div>
                                                            <div class="right_arrow">
                                                                <img src="/images/tcHolidays/chevron-down.svg"
                                                                    alt="" />
                                                            </div>
                                                        </div>
                                                        <div class="accordion-body">
                                                            <div class="content_box">
                                                                <div class="card_blc">
                                                                    <div class="card_top">
                                                                        <div class="icon">
                                                                            <img src="/images/tcHolidays/tc-PDP/arrow-narrow-down-right.svg"
                                                                                alt="" />
                                                                        </div>
                                                                        <p>Arrival in Italy</p>
                                                                    </div>
                                                                    <span class="sub_title">Upon arrival in Italy,
                                                                        proceed to your hotel and complete the check-in
                                                                        formalities.</span>
                                                                </div>
                                                                <div class="card_blc">
                                                                    <div class="card_top">
                                                                        <div class="icon">
                                                                            <img src="/images/tcHolidays/tc-PDP/hotels.svg"
                                                                                alt="" />
                                                                        </div>
                                                                        <p>Hotels</p>
                                                                    </div>
                                                                    <div class="hotelCard_slide owl-carousel">
                                                                        <div class="card_item">
                                                                            <div class="crb_lft">
                                                                                <img src="/images/tcHolidays/tc-PDP/building.svg"
                                                                                    alt="" />
                                                                            </div>
                                                                            <div class="crb_right">
                                                                                <span class="sub_title">Moxy CDG / Ibis
                                                                                    Styles CDG</span>
                                                                                <div class="rating">
                                                                                    <span class="stars">
                                                                                        <img src="/images/tcHolidays/star.svg"
                                                                                            alt="" />
                                                                                    </span>
                                                                                    <span><b>4.5</b>(1.5K)</span>
                                                                                </div>
                                                                            </div>
                                                                        </div>

                                                                        <div class="card_item">
                                                                            <div class="crb_lft">
                                                                                <img src="/images/tcHolidays/tc-PDP/hotel-building-02.png"
                                                                                    alt="" />
                                                                            </div>
                                                                            <div class="crb_right">
                                                                                <span class="sub_title">Moxy CDG / Ibis
                                                                                    Styles CDG</span>
                                                                                <div class="rating">
                                                                                    <span class="stars">
                                                                                        <img src="/images/tcHolidays/star.svg"
                                                                                            alt="" />
                                                                                    </span>
                                                                                    <span><b>4.7</b>(1.8K)</span>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="short_note"><span>Note:</span> The above
                                                                        mentioned hotels will be same or similar</div>
                                                                </div>
                                                                <div class="card_blc">
                                                                    <div class="card_top">
                                                                        <div class="icon">
                                                                            <img src="/images/tcHolidays/tc-PDP/camera-01.svg"
                                                                                alt="" />
                                                                        </div>
                                                                        <p>Sightseeing</p>
                                                                    </div>
                                                                    <div class="sight_blc">
                                                                        <div class="sight_item">
                                                                            <div class="sight_left">
                                                                                <img src="/images/tcHolidays/tc-PDP/sight-11.png"
                                                                                    alt="" />
                                                                            </div>
                                                                            <div class="sight_right">
                                                                                <p>Orientation Tour of Lucerne</p>
                                                                                <ul>
                                                                                    <li>Discover the charming city of
                                                                                        Lucerne with highlights like the
                                                                                        Lion Monument and the
                                                                                        Kapellbrücke (Chapel Bridge).
                                                                                    </li>
                                                                                    <li>Enjoy free time to stroll
                                                                                        around, shop for authentic Swiss
                                                                                        watches, knives, chocolates, and
                                                                                        unique souvenirs.</li>
                                                                                </ul>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="card_blc">
                                                                    <div class="card_top">
                                                                        <div class="icon">
                                                                            <img src="/images/tcHolidays/tc-PDP/meal.svg"
                                                                                alt="" />
                                                                        </div>
                                                                        <p>Meal</p>
                                                                    </div>
                                                                    <span class="sub_title">Breakfast, Lunch and
                                                                        Dinner</span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div id="tab9" class="tab-details">
                                                    <div class="accordion">
                                                        <div class="accordion-item">
                                                            <div class="left_blc">
                                                                <h6 class="accordion-header"><span class="day_chip">Day
                                                                        9</span>Italy</h6>
                                                            </div>
                                                            <div class="right_arrow">
                                                                <img src="/images/tcHolidays/chevron-down.svg"
                                                                    alt="" />
                                                            </div>
                                                        </div>
                                                        <div class="accordion-body">
                                                            <div class="content_box">
                                                                <div class="card_blc">
                                                                    <div class="card_top">
                                                                        <div class="icon">
                                                                            <img src="/images/tcHolidays/tc-PDP/arrow-narrow-down-right.svg"
                                                                                alt="" />
                                                                        </div>
                                                                        <p>Arrival in Italy</p>
                                                                    </div>
                                                                    <span class="sub_title">Upon arrival in Italy,
                                                                        proceed to your hotel and complete the check-in
                                                                        formalities.</span>
                                                                </div>
                                                                <div class="card_blc">
                                                                    <div class="card_top">
                                                                        <div class="icon">
                                                                            <img src="/images/tcHolidays/tc-PDP/hotels.svg"
                                                                                alt="" />
                                                                        </div>
                                                                        <p>Hotels</p>
                                                                    </div>
                                                                    <div class="hotelCard_slide owl-carousel">
                                                                        <div class="card_item">
                                                                            <div class="crb_lft">
                                                                                <img src="/images/tcHolidays/tc-PDP/building.svg"
                                                                                    alt="" />
                                                                            </div>
                                                                            <div class="crb_right">
                                                                                <span class="sub_title">Moxy CDG / Ibis
                                                                                    Styles CDG</span>
                                                                                <div class="rating">
                                                                                    <span class="stars">
                                                                                        <img src="/images/tcHolidays/star.svg"
                                                                                            alt="" />
                                                                                    </span>
                                                                                    <span><b>4.5</b>(1.5K)</span>
                                                                                </div>
                                                                            </div>
                                                                        </div>

                                                                        <div class="card_item">
                                                                            <div class="crb_lft">
                                                                                <img src="/images/tcHolidays/tc-PDP/hotel-building-02.png"
                                                                                    alt="" />
                                                                            </div>
                                                                            <div class="crb_right">
                                                                                <span class="sub_title">Moxy CDG / Ibis
                                                                                    Styles CDG</span>
                                                                                <div class="rating">
                                                                                    <span class="stars">
                                                                                        <img src="/images/tcHolidays/star.svg"
                                                                                            alt="" />
                                                                                    </span>
                                                                                    <span><b>4.7</b>(1.8K)</span>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="short_note"><span>Note:</span> The above
                                                                        mentioned hotels will be same or similar</div>
                                                                </div>
                                                                <div class="card_blc">
                                                                    <div class="card_top">
                                                                        <div class="icon">
                                                                            <img src="/images/tcHolidays/tc-PDP/camera-01.svg"
                                                                                alt="" />
                                                                        </div>
                                                                        <p>Sightseeing</p>
                                                                    </div>
                                                                    <div class="sight_blc">
                                                                        <div class="sight_item">
                                                                            <div class="sight_left">
                                                                                <img src="/images/tcHolidays/tc-PDP/sight-11.png"
                                                                                    alt="" />
                                                                            </div>
                                                                            <div class="sight_right">
                                                                                <p>Orientation Tour of Lucerne</p>
                                                                                <ul>
                                                                                    <li>Discover the charming city of
                                                                                        Lucerne with highlights like the
                                                                                        Lion Monument and the
                                                                                        Kapellbrücke (Chapel Bridge).
                                                                                    </li>
                                                                                    <li>Enjoy free time to stroll
                                                                                        around, shop for authentic Swiss
                                                                                        watches, knives, chocolates, and
                                                                                        unique souvenirs.</li>
                                                                                </ul>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="card_blc">
                                                                    <div class="card_top">
                                                                        <div class="icon">
                                                                            <img src="/images/tcHolidays/tc-PDP/meal.svg"
                                                                                alt="" />
                                                                        </div>
                                                                        <p>Meal</p>
                                                                    </div>
                                                                    <span class="sub_title">Breakfast, Lunch and
                                                                        Dinner</span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div id="tab10" class="tab-details">
                                                    <div class="accordion">
                                                        <div class="accordion-item">
                                                            <div class="left_blc">
                                                                <h6 class="accordion-header"><span class="day_chip">Day
                                                                        10</span>Germany</h6>
                                                            </div>
                                                            <div class="right_arrow">
                                                                <img src="/images/tcHolidays/chevron-down.svg"
                                                                    alt="" />
                                                            </div>
                                                        </div>
                                                        <div class="accordion-body">
                                                            <div class="content_box">
                                                                <div class="card_blc">
                                                                    <div class="card_top">
                                                                        <div class="icon">
                                                                            <img src="/images/tcHolidays/tc-PDP/arrow-narrow-down-right.svg"
                                                                                alt="" />
                                                                        </div>
                                                                        <p>Arrival in Italy</p>
                                                                    </div>
                                                                    <span class="sub_title">Upon arrival in Italy,
                                                                        proceed to your hotel and complete the check-in
                                                                        formalities.</span>
                                                                </div>
                                                                <div class="card_blc">
                                                                    <div class="card_top">
                                                                        <div class="icon">
                                                                            <img src="/images/tcHolidays/tc-PDP/hotels.svg"
                                                                                alt="" />
                                                                        </div>
                                                                        <p>Hotels</p>
                                                                    </div>
                                                                    <div class="hotelCard_slide owl-carousel">
                                                                        <div class="card_item">
                                                                            <div class="crb_lft">
                                                                                <img src="/images/tcHolidays/tc-PDP/building.svg"
                                                                                    alt="" />
                                                                            </div>
                                                                            <div class="crb_right">
                                                                                <span class="sub_title">Moxy CDG / Ibis
                                                                                    Styles CDG</span>
                                                                                <div class="rating">
                                                                                    <span class="stars">
                                                                                        <img src="/images/tcHolidays/star.svg"
                                                                                            alt="" />
                                                                                    </span>
                                                                                    <span><b>4.5</b>(1.5K)</span>
                                                                                </div>
                                                                            </div>
                                                                        </div>

                                                                        <div class="card_item">
                                                                            <div class="crb_lft">
                                                                                <img src="/images/tcHolidays/tc-PDP/hotel-building-02.png"
                                                                                    alt="" />
                                                                            </div>
                                                                            <div class="crb_right">
                                                                                <span class="sub_title">Moxy CDG / Ibis
                                                                                    Styles CDG</span>
                                                                                <div class="rating">
                                                                                    <span class="stars">
                                                                                        <img src="/images/tcHolidays/star.svg"
                                                                                            alt="" />
                                                                                    </span>
                                                                                    <span><b>4.7</b>(1.8K)</span>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="short_note"><span>Note:</span> The above
                                                                        mentioned hotels will be same or similar</div>
                                                                </div>
                                                                <div class="card_blc">
                                                                    <div class="card_top">
                                                                        <div class="icon">
                                                                            <img src="/images/tcHolidays/tc-PDP/camera-01.svg"
                                                                                alt="" />
                                                                        </div>
                                                                        <p>Sightseeing</p>
                                                                    </div>
                                                                    <div class="sight_blc">
                                                                        <div class="sight_item">
                                                                            <div class="sight_left">
                                                                                <img src="/images/tcHolidays/tc-PDP/sight-11.png"
                                                                                    alt="" />
                                                                            </div>
                                                                            <div class="sight_right">
                                                                                <p>Orientation Tour of Lucerne</p>
                                                                                <ul>
                                                                                    <li>Discover the charming city of
                                                                                        Lucerne with highlights like the
                                                                                        Lion Monument and the
                                                                                        Kapellbrücke (Chapel Bridge).
                                                                                    </li>
                                                                                    <li>Enjoy free time to stroll
                                                                                        around, shop for authentic Swiss
                                                                                        watches, knives, chocolates, and
                                                                                        unique souvenirs.</li>
                                                                                </ul>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="card_blc">
                                                                    <div class="card_top">
                                                                        <div class="icon">
                                                                            <img src="/images/tcHolidays/tc-PDP/meal.svg"
                                                                                alt="" />
                                                                        </div>
                                                                        <p>Meal</p>
                                                                    </div>
                                                                    <span class="sub_title">Breakfast, Lunch and
                                                                        Dinner</span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div id="tab11" class="tab-details">
                                                    <div class="accordion">
                                                        <div class="accordion-item">
                                                            <div class="left_blc">
                                                                <h6 class="accordion-header"><span class="day_chip">Day
                                                                        11</span>Fly back home</h6>
                                                            </div>
                                                            <div class="right_arrow">
                                                                <img src="/images/tcHolidays/chevron-down.svg"
                                                                    alt="" />
                                                            </div>
                                                        </div>
                                                        <div class="accordion-body">
                                                            <div class="content_box">
                                                                <div class="card_blc">
                                                                    <div class="card_top">
                                                                        <div class="icon">
                                                                            <img src="/images/tcHolidays/tc-PDP/arrow-narrow-down-right.svg"
                                                                                alt="" />
                                                                        </div>
                                                                        <p>Arrival in Italy</p>
                                                                    </div>
                                                                    <span class="sub_title">Upon arrival in Italy,
                                                                        proceed to your hotel and complete the check-in
                                                                        formalities.</span>
                                                                </div>
                                                                <div class="card_blc">
                                                                    <div class="card_top">
                                                                        <div class="icon">
                                                                            <img src="/images/tcHolidays/tc-PDP/camera-01.svg"
                                                                                alt="" />
                                                                        </div>
                                                                        <p>Sightseeing</p>
                                                                    </div>
                                                                    <div class="sight_blc">
                                                                        <div class="sight_item">
                                                                            <div class="sight_left">
                                                                                <img src="/images/tcHolidays/tc-PDP/sight-11.png"
                                                                                    alt="" />
                                                                            </div>
                                                                            <div class="sight_right">
                                                                                <p>Orientation Tour of Lucerne</p>
                                                                                <ul>
                                                                                    <li>Discover the charming city of
                                                                                        Lucerne with highlights like the
                                                                                        Lion Monument and the
                                                                                        Kapellbrücke (Chapel Bridge).
                                                                                    </li>
                                                                                    <li>Enjoy free time to stroll
                                                                                        around, shop for authentic Swiss
                                                                                        watches, knives, chocolates, and
                                                                                        unique souvenirs.</li>
                                                                                </ul>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="card_blc">
                                                                    <div class="card_top">
                                                                        <div class="icon">
                                                                            <img src="/images/tcHolidays/tc-PDP/meal.svg"
                                                                                alt="" />
                                                                        </div>
                                                                        <p>Meal</p>
                                                                    </div>
                                                                    <span class="sub_title">Breakfast, Lunch and
                                                                        Dinner</span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div> -->
                                       
                                        </div>
                                    </div>
                                    <div class="tab-pane fade" id="nav-inclusions" role="tabpanel"
                                        aria-labelledby="nav-inclusions-tab">
                                        <div class="tab-container tab_inclusions">
                                            <div class="tab-left">
                                                <div class="tabs">
                                                    <div class="tab-indicator"></div>
                                                    <button class="tab-btn active" data-tab="flights"  v-if="getFlagByIndex(packageDetailsResponse?.[0]?.packageDetail?.isFlightIncluded,selectedPackageClassId) === 'Y'" >Flights</button>
                                                    <button class="tab-btn" data-tab="hotels" v-if="getFlagByIndex(packageDetailsResponse?.[0]?.packageDetail?.isHotelDetailsIncluded,selectedPackageClassId) === 'Y'" >Hotels</button>
                                                    <button class="tab-btn" data-tab="sightseeing" v-if="getFlagByIndex(packageDetailsResponse?.[0]?.packageDetail?.isSightseeingDetailsIncluded,selectedPackageClassId) === 'Y'" >Sightseeing</button>
                                                    <button class="tab-btn" data-tab="visa" v-if="getFlagByIndex(packageDetailsResponse?.[0]?.packageDetail?.isVisaIncluded,selectedPackageClassId) === 'Y'" >Visa</button>
                                                    <button class="tab-btn" data-tab="insurance" v-if="getFlagByIndex(packageDetailsResponse?.[0]?.packageDetail?.isInsuranceIncluded,selectedPackageClassId) === 'Y'" >Insurance</button>
                                                    <button class="tab-btn" data-tab="meals" v-if="getFlagByIndex(packageDetailsResponse?.[0]?.packageDetail?.isMealDetailsIncluded,selectedPackageClassId) === 'Y'" >Meals</button>
                                                    <button class="tab-btn" data-tab="transfer">Transfer</button>
                                                    <button class="tab-btn" data-tab="tour-manager" v-if="getFlagByIndex(packageDetailsResponse?.[0]?.packageDetail?.isTourManagerIncluded,selectedPackageClassId) === 'Y'" >Tour
                                                        Manager</button>
                                                    <button class="tab-btn" data-tab="Others">Others</button>
                                                    <button class="tab-btn tab-highlights"
                                                        data-tab="exclusions">Exclusions</button>
                                                    <button class="tab-btn tab-highlights"
                                                        data-tab="things-to-note">Things to Note</button>
                                                </div>
                                            </div>
                                            <div class="tab-right inclusions_details">
                                                <div id="flights" class="tab-details" v-if="packageDetailsResponse?.[0]?.packageDetail?.isFlightIncluded==='Y'">
                                                    <div class="tab_card">
                                                        <div class="card_top">
                                                            <img src="/images/tcHolidays/tc-PDP/plane-01.svg" alt="" />
                                                            <h6>Flights</h6>
                                                        </div>
                                                        <div class="tabDetails_wrapper">
                                                            <div class="card_bottom">
                                                               <div v-html="packageDetailsResponse?.[0]?.packageDetail.flightDefaultMsg"></div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                
<div id="hotels" class="tab-details" v-if="getFlagByIndex(packageDetailsResponse?.[0]?.packageDetail?.isHotelDetailsIncluded,selectedPackageClassId) === 'Y'">
    <div class="tab_card">
        <div class="card_top">
            <img src="/images/tcHolidays/tc-PDP/building-03.svg" alt="" />
            <h6>Hotels</h6>
        </div>
        <div class="tabDetails_wrapper">
            <div class="card_bottom">
                <template v-for="(accommodation, index) in filteredAccommodations" :key="accommodation.accomodationDetailId">
                    <div class="hotel_location">
                        <p class="title">
                            {{ accommodation.accomodationHotelId.cityCode.cityName }} 
                            <span>({{ accommodation.noOfNights }}N/{{ accommodation.day }}D)</span>
                        </p>
                        <span class="sub_title">
                            {{ accommodation.accomodationHotelId.hotelName }} in {{ accommodation.accomodationHotelId.location }}
                        </span>
                        <div class="rating">
                            <span class="stars">
                                <img src="/images/tcHolidays/star.svg" alt="" />
                            </span>
                            <span>{{ accommodation.accomodationHotelId.starRating }}</span><span>(1.5K)</span></span>
                        </div>
                    </div>
                    <div class="seperator" v-if="index < filteredAccommodations.length - 1"></div>
                </template>
            </div>
        </div>
    </div>
</div>
                                                <!-- <div id="hotels" class="tab-details">
                                                    <div class="tab_card">
                                                        <div class="card_top">
                                                            <img src="/images/tcHolidays/tc-PDP/building-03.svg" alt="" />
                                                            <h6>Hotels</h6>
                                                        </div>
                                                        <div class="tabDetails_wrapper">
                                                            <div class="card_bottom">
                                                                <div class="hotel_location">
                                                                    <p class="title">Paris <span>(1N/2D)</span></p>
                                                                    <span class="sub_title">Moxy CDG / Ibis Styles CDG
                                                                        or similar in Paris (CDG Area)</span>
                                                                    <div class="rating">
                                                                        <span class="stars"> <img
                                                                                src="/images/tcHolidays/star.svg"
                                                                                alt="" /></span>

                                                                        <span>4.5<span>(1.5K)</span></span>
                                                                    </div>
                                                                </div>
                                                                <div class="seperator"></div>
                                                                <div class="hotel_location">
                                                                    <p class="title">
                                                                        Switzerland
                                                                        <span>(1N/2D)</span>
                                                                    </p>
                                                                    <span class="sub_title">Hotel Ibis Style / Harry’s
                                                                        Home / Novotel Zurich Messe / Prizeotel
                                                                        Affoltern am Albis or similar in Basel / Zurich,
                                                                        Switzerland</span>
                                                                    <div class="rating">
                                                                        <span class="stars"> <img
                                                                                src="/images/tcHolidays/star.svg"
                                                                                alt="" /></span>

                                                                        <span>4.5<span>(1.5K)</span></span>
                                                                    </div>
                                                                </div>
                                                                <div class="seperator"></div>
                                                                <div class="hotel_location">
                                                                    <p class="title">
                                                                        Switzerland
                                                                        <span>(1N/2D)</span>
                                                                    </p>
                                                                    <span class="sub_title">Hotel Coronado / Serpiano or
                                                                        similar in Mendriso / Serpiano,
                                                                        Switzerland</span>
                                                                    <div class="rating">
                                                                        <span class="stars"> <img
                                                                                src="/images/tcHolidays/star.svg"
                                                                                alt="" /></span>

                                                                        <span>4.5<span>(1.5K)</span></span>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div> -->
                                               

<div id="sightseeing" class="tab-details" v-if="getFlagByIndex(packageDetailsResponse?.[0]?.packageDetail?.isSightseeingDetailsIncluded,selectedPackageClassId) === 'Y'">
    <div class="tab_card">
        <div class="card_top">
            <img src="/images/tcHolidays/tc-PDP/camera-02.svg" alt="" />
            <h6>Sightseeing</h6>
        </div>
        <div class="tabDetails_wrapper">
            <div class="card_bottom">
                <!-- Check if sightseeing data exists -->
                <template v-if="sighSeeingDetailCollection()">
                    <!-- Loop through the sightseeing collection array -->
                  
                    <template v-for="(item, index) in sighSeeingDetailCollection()" :key="'sight-item-' + index">
                        <div class="comn_blck">
                            <!-- Use city name as title -->

                            <p class="title">{{ (item.sightseeingId?.cityCode?.cityName || item.sightseeingId?.cityCode?.tcilMstCountryStateMapping?.stateName || item.sightseeingId?.cityCode?.tcilMstCountryStateMapping?.tcilMstCountryContinentMapping?.countryName || 'UNKNOWN LOCATION').toUpperCase() }}</p>
                            
                            <!-- Display sightseeing name or description -->
                            <span class="sub_title">
                                {{ item.sightseeingId?.name || item.sightseeingId?.description  }}
                            </span>
                        </div>
                        
                        <!-- Add separator between items, except for the last one -->
                        <div class="seperator" v-if="index < (sighSeeingDetailCollection().length - 1)"></div>
                    </template>
                </template>
                
                <!-- Fallback if no sightseeing data -->
                <div class="comn_blck" v-else>
                    <p class="title">NO SIGHTSEEING DATA AVAILABLE</p>
                    <span class="sub_title">Sightseeing information will be updated soon.</span>
                </div>
            </div>
        </div>
    </div>
</div>
    
                                               
                                                <!-- <div id="sightseeing" class="tab-details">
                                                    <div class="tab_card">
                                                        <div class="card_top">
                                                            <img src="/images/tcHolidays/tc-PDP/camera-02.svg" alt="" />
                                                            <h6>Sightseeing</h6>
                                                        </div>
                                                        <div class="tabDetails_wrapper">
                                                            <div class="card_bottom">
                                                                <div class="comn_blck">
                                                                    <p class="title">PARIS</p>
                                                                    <ul class="unlisted">
                                                                        <li>Guided city tour</li>
                                                                        <li>Guided Tour of Versailles Palace</li>
                                                                        <li>Visit 2nd level of the Eiffel Tower</li>
                                                                        <li>Visit Fragonard – French Perfume Museum</li>
                                                                        <li>Enjoy Illumination Tour of Paris</li>
                                                                        <li>Seine River Cruise</li>
                                                                        <li>Visit Disneyland® Paris·(01 Day 01 Park)
                                                                        </li>
                                                                    </ul>
                                                                </div>

                                                                <div class="seperator"></div>

                                                                <div class="comn_blck">
                                                                    <p class="title">SWITZERLAND</p>
                                                                    <ul class="unlisted">
                                                                        <li>Visit Mt. Titlis</li>
                                                                        <li>Orientation tour of Lucerne</li>
                                                                    </ul>
                                                                </div>

                                                                <div class="seperator"></div>

                                                                <div class="comn_blck">
                                                                    <p class="title">ITALY</p>
                                                                </div>

                                                                <div class="seperator"></div>

                                                                <div class="comn_blck">
                                                                    <p class="title">COMO</p>
                                                                    <span class="sub_title">Photo Stop at Lake
                                                                        Como</span>
                                                                </div>

                                                                <div class="seperator"></div>

                                                                <div class="comn_blck">
                                                                    <p class="title">PISA</p>
                                                                    <span class="sub_title">Visit Field of Miracles –
                                                                        See the Leaning Tower of Pisa</span>
                                                                </div>

                                                                <div class="seperator"></div>

                                                                <div class="comn_blck">
                                                                    <p class="title">ROME</p>
                                                                    <span class="sub_title">Guided city tour</span>
                                                                </div>

                                                                <div class="seperator"></div>

                                                                <div class="comn_blck">
                                                                    <p class="title">VATICAN CITY</p>
                                                                    <span class="sub_title">Visit St. Peter’s Basilica
                                                                        and Square</span>
                                                                </div>

                                                                <div class="seperator"></div>

                                                                <div class="comn_blck">
                                                                    <p class="title">VENICE</p>
                                                                    <ul class="unlisted">
                                                                        <li>Visit St. Mark’s square on a private boat
                                                                        </li>
                                                                        <li>Orientation tour of Venice</li>
                                                                    </ul>
                                                                </div>

                                                                <div class="seperator"></div>

                                                                <div class="comn_blck">
                                                                    <p class="title">AUSTRIA</p>
                                                                    <ul class="unlisted">
                                                                        <li>Visit St. Mark’s square on a private boat
                                                                        </li>
                                                                        <li>Orientation tour of Venice</li>
                                                                    </ul>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div> -->



                                                 <div v-if="packageDetailsResponse?.[0]?.packageDetail?.isVisaIncluded === 'Y'" id="visa" class="tab-details">
    <div class="tab_card">
        <div class="card_top">
            <img src="/images/tcHolidays/tc-PDP/passport.svg" alt="" />
            <h6>Visa</h6>
        </div>
        <div class="tabDetails_wrapper">
            <div class="card_bottom">
                <!-- Show default visa message -->
                <div class="comn_blck" v-if="packageDetailsResponse?.[0]?.packageDetail?.isVisaDefaultMsg === 'Y'">
                    <p class="title">Visa requirements</p>
                    <span class="sub_title" v-html="packageDetailsResponse[0].packageDetail.visaDefaultMsg"></span>
                </div>

                <!-- Show visa from collection based on package class -->
                <template v-else-if="packageDetailsResponse?.[0]?.packageDetail?.isVisaDefaultMsg === 'N'">
                    <div class="comn_blck" v-for="visa in filteredVisaCollection" :key="visa.visaId || visa.packageClassId">
                        <p class="title">Visa requirements</p>
                        <span class="sub_title" v-html="visa.visa"></span>
                    </div>
                </template>

                <div class="comn_blck">
                    <p class="title">Passport</p>
                    <span class="sub_title">Passport should be valid for 6 months from the date of departure</span>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="insurance" class="tab-details" v-if="packageDetailsResponse?.[0]?.packageDetail?.isInsuranceIncluded === 'Y'">
    <div class="tab_card">
        <div class="card_top">
            <img src="/images/tcHolidays/tc-PDP/shield-tick.svg" alt="" />
            <h6>Insurance</h6>
        </div>
        <div class="tabDetails_wrapper">
            <div class="card_bottom">
                <!-- Show default insurance message -->
                <template v-if="packageDetailsResponse?.[0]?.packageDetail?.isInsuranceDefaultMsg === 'Y'">
                    <div class="comn_blck">
                        <p class="title">Medical insurance</p>
                        <span class="sub_title" v-html="packageDetailsResponse[0].packageDetail.insuranceDefaultMsg"></span>
                    </div>
                </template>

                <!-- Show insurance from collection based on package class -->
                <template v-else-if="packageDetailsResponse?.[0]?.packageDetail?.isInsuranceDefaultMsg === 'N'">
                    <div class="comn_blck" v-for="visa in filteredVisaCollection" :key="'insurance-' + (visa.visaId || visa.packageClassId)">
                        <p class="title">Medical insurance</p>
                        <span class="sub_title" v-html="visa.insurance"></span>
                    </div>
                </template>
            </div>
        </div>
    </div>
</div>

                                                <!-- <div id="visa" class="tab-details" v-if="packageDetailsResponse[0].packageDetail.isVisaIncluded === 'Y">
                                                    <div class="tab_card">
                                                        <div class="card_top">
                                                            <img src="/images/tcHolidays/tc-PDP/passport.svg" alt="" />
                                                            <h6>Visa</h6>
                                                        </div>
                                                        <div class="tabDetails_wrapper">
                                                            <div class="card_bottom">
                                                                <div class="comn_blck" v-if="packageDetailsResponse?[0].packageDetail.isVisaDefaultMsg === 'Y'">
                                                                    <p class="title">Visa requirements</p>
                                                                    <span class="sub_title" v-html="packageDetailsResponse[0].packageDetail.visaDefaultMsg">UAE Visa Charges</span>
                                                                </div>

                                                                <div class="comn_blck">
                                                                    <p class="title">Passport</p>
                                                                    <span class="sub_title">Passport should be valid for
                                                                        6 months from the date of departure</span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div id="insurance" class="tab-details">
                                                    <div class="tab_card">
                                                        <div class="card_top">
                                                            <img src="/images/tcHolidays/tc-PDP/shield-tick.svg" alt="" />
                                                            <h6>Insurance</h6>
                                                        </div>
                                                        <div class="tabDetails_wrapper">
                                                            <div class="card_bottom">
                                                                <div class="comn_blck">
                                                                    <p class="title">Medical insurance</p>
                                                                    <span class="sub_title">Travel Insurance as required
                                                                        for the package (For passengers till 60 years of
                                                                        age) </span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div> -->
                                              
<div id="meals" class="tab-details" v-if="getFlagByIndex(packageDetailsResponse?.[0]?.packageDetail?.isMealDetailsIncluded,selectedPackageClassId) === 'Y'">
    <div class="tab_card">
        <div class="card_top">
            <img src="/images/tcHolidays/tc-PDP/meals.svg" alt="" />
            <h6>Meals</h6>
        </div>
        <div class="tabDetails_wrapper">
            <div class="card_bottom">
                <div class="comn_blck">
                    <!-- Show default meals message -->
                    <div v-if="packageDetailsResponse?.[0]?.packageDetail?.isMealsDefaultMsg === 'Y'">
                        <div v-html="packageDetailsResponse[0].packageDetail.mealsDefaultMsg"></div>
                    </div>

                    <!-- Show meals from collection based on package class -->
                    <template v-else-if="packageDetailsResponse?.[0]?.packageDetail?.isMealsDefaultMsg === 'N' && filteredMealCollection.length > 0">
                        <div class="items_inr">
                            <div class="item_blck" v-for="meal in filteredMealCollection" :key="meal.mealId || meal.packageClassId">
                                <div class="icon">
                                    <img 
                                        :src="meal.tcilMstMeal.imagePath ? (imageURL + holidayImageURL + 'meal/' + meal.tcilMstMeal.imagePath) : '/images/tcHolidays/tc-PDP/meal.svg'" 
                                        :alt="meal.tcilMstMeal.imageAltTag || 'Meal'" />
                                </div>
                                <span class="sub_title" v-html="meal.tcilMstMeal.mealDescription"></span>
                            </div>
                        </div>

                        <!-- Special treats section (if available in meal data) -->
                        <template v-if="mealSpecialTreats.length > 0">
                            <div class="item_blck">
                                <div class="icon">
                                    <img src="/images/tcHolidays/tc-PDP/star-02.svg" alt="Special Treats" />
                                </div>
                                <span class="sub_title">Special Treats</span>
                            </div>
                            <ul class="special_treat unlisted">
                                <li v-for="(treat, index) in mealSpecialTreats" :key="index">{{ treat }}</li>
                            </ul>
                        </template>

                        <!-- Note section (if available) -->
                        <div class="note" v-if="mealNote">
                            <span v-html="mealNote"></span>
                        </div>
                    </template>
                </div>
            </div>
        </div>
    </div>
</div>


                                                <!-- <div id="meals" class="tab-details">
                                                    <div class="tab_card">
                                                        <div class="card_top">
                                                            <img src="/images/tcHolidays/tc-PDP/meals.svg" alt="" />
                                                            <h6>Meals</h6>
                                                        </div>
                                                        <div class="tabDetails_wrapper">
                                                            <div class="card_bottom">
                                                                <div class="comn_blck">
                                                                    <div class="items_inr">
                                                                        <div class="item_blck">
                                                                            <div class="icon">
                                                                                <img src="/images/tcHolidays/tc-PDP/meal.svg"
                                                                                    alt="" />
                                                                            </div>
                                                                            <span class="sub_title">10 Daily breakfast,
                                                                                except on Day 1</span>
                                                                        </div>

                                                                        <div class="item_blck">
                                                                            <div class="icon">
                                                                                <img src="/images/tcHolidays/tc-PDP/meals-02.svg"
                                                                                    alt="" />
                                                                            </div>
                                                                            <span class="sub_title">9 Lunches, 2 Packed
                                                                                Lunches and 10 Dinner as per
                                                                                itinerary</span>
                                                                        </div>

                                                                        <div class="item_blck">
                                                                            <div class="icon">
                                                                                <img src="/images/tcHolidays/tc-PDP/meals-02.svg"
                                                                                    alt="" />
                                                                            </div>
                                                                            <span class="sub_title">07 Indian Jain /
                                                                                Vegetarian / Non-Vegetarian
                                                                                Dinners.</span>
                                                                        </div>

                                                                        <div class="item_blck">
                                                                            <div class="icon">
                                                                                <img src="/images/tcHolidays/tc-PDP/star-02.svg"
                                                                                    alt="" />
                                                                            </div>
                                                                            <span class="sub_title">Special
                                                                                Treats</span>
                                                                        </div>
                                                                    </div>
                                                                    <ul class="special_treat unlisted">
                                                                        <li>Mochi Tasting</li>
                                                                        <li>Rice Cracker Tasting</li>
                                                                        <li>Pocky Tasting</li>
                                                                        <li>Sushi Tasting</li>
                                                                    </ul>

                                                                    <div class="note">
                                                                        <span><b>Note:</b> Packed lunches, if
                                                                            applicable, will
                                                                            be Jain / vegetarian. In certain places,
                                                                            there is a possibility of providing cash out
                                                                            to the passengers instead of packed
                                                                            lunches</span>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div> -->
                                                
                                                <div id="transfer" class="tab-details">
                                                    <div class="tab_card">
                                                        <div class="card_top">
                                                            <img src="/images/tcHolidays/tc-PDP/car-01.svg" alt="" />
                                                            <h6>Transfer</h6>
                                                        </div>
                                                        <div class="tabDetails_wrapper">
                                                            <div class="card_bottom">
                                                                <div class="comn_blck">
                                                                    <span class="sub_title">All transfers and extensive
                                                                        excursions with entrance fees (as specified in
                                                                        the itinerary) by a deluxe air conditioned
                                                                        coach.</span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div id="tour-manager" class="tab-details" v-if="packageDetailsResponse?.[0]?.packageDetail?.tourManagerDescription=='Y'">
                                                    <div class="tab_card">
                                                        <div class="card_top">
                                                            <img src="/images/tcHolidays/tc-PDP/user-01.svg" alt="" />
                                                            <h6>Tour Manager</h6>
                                                        </div>
                                                        <div class="tabDetails_wrapper">
                                                            <div class="card_bottom">
                                                                <div class="comn_blck">
                                                                     <span class="sub_title" v-if="packageDetailsResponse[0]?.packageDetail?.tourManagerDescription">
                                                                       {{packageDetailsResponse[0]?.packageDetail?.tourManagerDescription}}
                                                                    </span>
                                                                   
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>



                            <!-- Others Tab - Inclusions -->
<div id="Others" class="tab-details">
    <div class="tab_card">
        <div class="card_top">
            <img src="/images/tcHolidays/tc-PDP/check-white.svg" alt="" />
            <h6>What your tour price includes?</h6>
        </div>
        <div class="tabDetails_wrapper">
            <div class="card_bottom">
                <div class="comn_blck">
                    
                    <!-- Check if inclusions data exists -->
                    <div>
                        <!-- Loop through inclusion/exclusion collection -->
                        <ul class="ul_withImg" v-for="(item,index) in inclusionExclusionCollection" key="item.packageClassId">
                             <li v-if="item.packageClassId === selectedPackageClassId"><img src="/images/tcHolidays/tc-PDP/check.svg" alt="" />
                            <span  v-html="item.includes"></span></li>
                        </ul>
                    </div>

                    <!-- Fallback static content if no data -->
                    <!-- <ul class="ul_withImg" v-else>
                        <li><img src="/images/tcHolidays/tc-PDP/check.svg" alt="" /> Return economy class group airfare as per the itinerary.</li>
                        <li><img src="/images/tcHolidays/tc-PDP/check.svg" alt="" /> All local taxes and services as of current date.</li>
                        <li><img src="/images/tcHolidays/tc-PDP/check.svg" alt="" /> Cost of Visa and Medical Insurance for the duration of the tour.</li>
                        <li><img src="/images/tcHolidays/tc-PDP/check.svg" alt="" /> Sightseeing and accommodation as per the above-mentioned itinerary.</li>
                        <li><img src="/images/tcHolidays/tc-PDP/check.svg" alt="" /> All transfers and extensive excursions with entrance fees (as specified in the itinerary) by a deluxe air-conditioned coach.</li>
                        <li><img src="/images/tcHolidays/tc-PDP/check.svg" alt="" /> Services of a professional, friendly and multilingual Tour Manager or a local Representative. (Subject to minimum 15 customers).</li>
                    </ul> -->
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Exclusions Tab -->
<div id="exclusions" class="tab-details exclusions_ttn">
    <div class="tab_card">
        <div class="card_top">
            <img src="/images/tcHolidays/tc-PDP/x-close-white.svg" alt="" />
            <h6>What your tour price does not include?</h6>
        </div>
        <div class="tabDetails_wrapper">
            <div class="card_bottom">
                <div class="comn_blck">
                    <!-- Check if exclusions data exists -->
                    <div v-if="inclusionExclusionCollection && inclusionExclusionCollection.length > 0">
                        <!-- Loop through inclusion/exclusion collection -->
                         <div>
                        <!-- Loop through inclusion/exclusion collection -->
                        <ul class="ul_withImg" v-for="(item,index) in inclusionExclusionCollection" key="item.packageClassId">
                             <li v-if="item.packageClassId === selectedPackageClassId"><img src="/images/tcHolidays/tc-PDP/x-close.svg">
                            <span  v-html="item.excludes"></span></li>
                        </ul>
                    </div>

                    </div>

                    <!-- Fallback static content if no data -->
                    <ul class="ul_withImg" v-else>
                        <li><img src="/images/tcHolidays/tc-PDP/x-close.svg" alt="" /> If you wish to travel in advance i.e., before the published departure date as mentioned in the brochure or like to come back on a later date after the tour ends, there will be an additional charge that will be applicable (subject to availability of seats for the given dates & ticket validity) which will be advised to you by our sales staff / travel agent. Kindly note, the deviation will be actioned only 30 Days prior to departure date.</li>
                        <li><img src="/images/tcHolidays/tc-PDP/x-close.svg" alt="" /> Tipping is expected from anyone providing your service e.g., Coach Driver, Local Guides, Hotel & Restaurant staff etc. It is mandatory to tip a nominal amount per person/per day.</li>
                        <li><img src="/images/tcHolidays/tc-PDP/x-close.svg" alt="" /> Cost of Basic Travel Quota equivalent to USD 250,000.</li>
                        <li><img src="/images/tcHolidays/tc-PDP/x-close.svg" alt="" /> Any increase in the airfare charged by the airline on your air ticket</li>
                        <li><img src="/images/tcHolidays/tc-PDP/x-close.svg" alt="" /> Government Taxes as applicable are extra.</li>
                        <li><img src="/images/tcHolidays/tc-PDP/x-close.svg" alt="" /> The tour cost does not include POE charges and passport charges.</li>
                        <li><img src="/images/tcHolidays/tc-PDP/x-close.svg" alt="" /> No porterage included.</li>
                        <li><img src="/images/tcHolidays/tc-PDP/x-close.svg" alt="" /> Any expenses of a personal nature such as porterage, laundry expenses, wines, mineral water, food and drink not in the regular menu provided by us, minibar, telephone calls, etc.</li>
                        <li><img src="/images/tcHolidays/tc-PDP/x-close.svg" alt="" /> Meals other than that are mentioned in your itinerary.</li>
                        <li><img src="/images/tcHolidays/tc-PDP/x-close.svg" alt="" /> Cost of excursions, city sightseeing, entrance fees and local guides availed of by the passengers, other than that mentioned in your itinerary.</li>
                        <li><img src="/images/tcHolidays/tc-PDP/x-close.svg" alt="" /> Private airport transfers, Cost of Suggested / Optional Excursions.</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>

                                                
                                                <!-- <div id="Others" class="tab-details">
                                                    <div class="tab_card">
                                                        <div class="card_top">
                                                            <img src="/images/tcHolidays/tc-PDP/check-white.svg" alt="" />
                                                            <h6>What your tour price includes?</h6>
                                                        </div>
                                                        <div class="tabDetails_wrapper">
                                                            <div class="card_bottom">
                                                                <div class="comn_blck">
                                                                    <ul class="ul_withImg">
                                                                        <li><img src="/images/tcHolidays/tc-PDP/check.svg"
                                                                                alt="" /> Return economy class group
                                                                            airfare as per the itinerary.</li>
                                                                        <li><img src="/images/tcHolidays/tc-PDP/check.svg"
                                                                                alt="" /> All local taxes and services
                                                                            as of 30th September 2024.</li>
                                                                        <li><img src="/images/tcHolidays/tc-PDP/check.svg"
                                                                                alt="" /> Cost of Visa and Medical
                                                                            Insurance for the duration of the tour.</li>
                                                                        <li><img src="/images/tcHolidays/tc-PDP/check.svg"
                                                                                alt="" /> Sightseeing and accommodation
                                                                            as per the above-mentioned itinerary.</li>
                                                                        <li>
                                                                            <img src="/images/tcHolidays/tc-PDP/check.svg"
                                                                                alt="" /> All transfers and extensive
                                                                            excursions with entrance fees (as specified
                                                                            in the itinerary) by a deluxe
                                                                            air-conditioned coach.
                                                                        </li>
                                                                        <li>
                                                                            <img src="/images/tcHolidays/tc-PDP/check.svg"
                                                                                alt="" /> Services of a professional,
                                                                            friendly and multilingual Tour Manager or a
                                                                            local Representative. (Subject to minimum
                                                                            15 customers).
                                                                        </li>
                                                                    </ul>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div id="exclusions" class="tab-details exclusions_ttn">
                                                    <div class="tab_card">
                                                        <div class="card_top">
                                                            <img src="/images/tcHolidays/tc-PDP/x-close-white.svg" alt="" />
                                                            <h6>What your tour price does not include?</h6>
                                                        </div>
                                                        <div class="tabDetails_wrapper">
                                                            <div class="card_bottom">
                                                                <div class="comn_blck">
                                                                    <ul class="ul_withImg">
                                                                        <li>
                                                                            <img src="/images/tcHolidays/tc-PDP/x-close.svg"
                                                                                alt="" /> If you wish to travel in
                                                                            advance i.e., before the published departure
                                                                            date as mentioned in the brochure or like
                                                                            to come back on a later date after the tour
                                                                            ends, there will be an additional charge
                                                                            that will be applicable (subject to
                                                                            availability of seats for the given
                                                                            dates & ticket validity) which will be
                                                                            advised to you by our sales staff / travel
                                                                            agent. Kindly note, the deviation will be
                                                                            actioned only 30 Days prior to
                                                                            departure date.
                                                                        </li>
                                                                        <li>
                                                                            <img src="/images/tcHolidays/tc-PDP/x-close.svg"
                                                                                alt="" /> Tipping is expected from
                                                                            anyone providing your service e.g., Coach
                                                                            Driver, Local Guides, Hotel & Restaurant
                                                                            staff etc. It is mandatory to tip a nominal
                                                                            amount of EUR 3 per person/per day. For the
                                                                            entire duration of this tour, which is 08
                                                                            Days, the total Tips amount is
                                                                            EUR 24 per person to be paid to the Tour
                                                                            Manager on Day 01 of the tour.
                                                                        </li>
                                                                        <li><img src="/images/tcHolidays/tc-PDP/x-close.svg"
                                                                                alt="" /> Cost of Basic Travel Quota
                                                                            equivalent to USD 250,000.</li>
                                                                        <li>
                                                                            <img src="/images/tcHolidays/tc-PDP/x-close.svg"
                                                                                alt="" /> Any increase in the airfare
                                                                            charged by the airline on your air ticket
                                                                            (presently calculated as on 30th September
                                                                            2024)
                                                                        </li>
                                                                        <li>
                                                                            <img src="/images/tcHolidays/tc-PDP/x-close.svg"
                                                                                alt="" />
                                                                            Government Taxes as applicable are extra.
                                                                        </li>
                                                                        <li><img src="/images/tcHolidays/tc-PDP/x-close.svg"
                                                                                alt="" /> The tour cost does not include
                                                                            POE charges and passport charges.</li>
                                                                        <li><img src="/images/tcHolidays/tc-PDP/x-close.svg"
                                                                                alt="" /> No porterage included.</li>
                                                                        <li>
                                                                            <img src="/images/tcHolidays/tc-PDP/x-close.svg"
                                                                                alt="" />
                                                                            Any expenses of a personal nature such as
                                                                            porterage, laundry expenses, wines, mineral
                                                                            water, food and drink not in the regular
                                                                            menu provided by us, minibar,
                                                                            telephone calls, etc.
                                                                        </li>
                                                                        <li><img src="/images/tcHolidays/tc-PDP/x-close.svg"
                                                                                alt="" /> Meals other than that are
                                                                            mentioned in your itinerary.</li>
                                                                        <li>
                                                                            <img src="/images/tcHolidays/tc-PDP/x-close.svg"
                                                                                alt="" /> Cost of excursions, city
                                                                            sightseeing, entrance fees and local guides
                                                                            availed of by the passengers, other than
                                                                            that mentioned in your itinerary.
                                                                        </li>
                                                                        <li><img src="/images/tcHolidays/tc-PDP/x-close.svg"
                                                                                alt="" /> Private airport transfers,
                                                                            Cost of Suggested / Optional Excursions.
                                                                        </li>
                                                                    </ul>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div> -->


                                                <div id="things-to-note" class="tab-details exclusions_ttn">
                                                    <div class="tab_card">
                                                        <div class="card_top">
                                                            <img src="/images/tcHolidays/tc-PDP/clipboard-check.svg" alt="" />
                                                            <h6>Things to Note</h6>
                                                        </div>
                                                        <div class="tabDetails_wrapper">
                                                            <div class="card_bottom">
                                                                <div class="comn_blck">
                                                                    <ul class="ul_withImg">
                                                                        <li><span>1.</span> As everyone is becoming a
                                                                            frequent traveller now, we suggest that you
                                                                            make your own travel accessories kit to
                                                                            ensure a stress free holiday.</li>
                                                                        <li>
                                                                            <span>2.</span>Always make sure to carry
                                                                            less and light luggage, use a four wheel
                                                                            small or medium suitcase and please make
                                                                            sure that you are carrying only one
                                                                            suitcase per person. This will ensure that
                                                                            you will travel smartly and without any
                                                                            inconveniences.
                                                                        </li>
                                                                        <li>
                                                                            <span>3.</span>It is also recommended that
                                                                            you have one cross shoulder bag or haversack
                                                                            for your handy needs which will ensure that
                                                                            you are comfortable at the
                                                                            time of sightseeing and also easy for
                                                                            photography during your tour.
                                                                        </li>
                                                                        <li><span>4.</span>A smart cap/hat and
                                                                            sunglasses are definitely something that you
                                                                            should have in your kit</li>
                                                                    </ul>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tab-pane fade" id="nav-summary" role="tabpanel"
                                        aria-labelledby="nav-summary-tab">
                                        <div class="tab-container tab_summary">
                                            <div class="tab-right summary_details">
                                                <div class="arriavl_dapt">
                                                    <img src="/images/tcHolidays/tc-PDP/plane.svg" alt="" />
                                                    <span v-html="packageDetailsResponse[0]?.packageDetail.flightDefaultMsg"></span>
													</div>
                          
                         

                                                     <div class="tab_card">
    <div class="card_top">
      <h6>Day wise summary</h6>
    </div>
    <div class="dayWise_grid">
        
      <div v-for="(row, index) in groupedRows" :key="index" class="grid_row">
        <div v-for="item in row" :key="item.accomodationDetailId" class="grid_item">
          <div class="days_blck">
            <span>Day {{ item.day }}</span>
            <p>{{ item.accomodationHotelId.city }}</p>
          </div>
          <div class="details_blck">
            <div class="db_item">
              <img src="/images/tcHolidays/tc-PDP/hotels.svg" alt="" />
              <span>
                {{ item.accomodationHotelId.hotelName }} in 
                {{ item.accomodationHotelId.city }}, 
                {{ item.accomodationHotelId.country }}.
              </span>
            </div>
            <div class="db_item">
              <img src="/images/tcHolidays/tc-PDP/camera-01.svg" alt="" v-if="getSightSeeingByDayAndPackage(item.day, selectedPackageClassId)?.sightseeingId" />
              <span>{{getSightSeeingByDayAndPackage(item.day, selectedPackageClassId)?.sightseeingId?.name }} </span>
            </div>
            <div class="db_item">
              <img src="/images/tcHolidays/tc-PDP/meals-02.svg" alt="" />
              <span>{{ getMealText(item.day, selectedPackageClassId) }}</span>
            </div>
            <div class="db_item">
              <img src="/images/tcHolidays/tc-PDP/car.svg" alt="" />
              <span>Shared transfers by a deluxe air-conditioned coach.</span>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>


                                               
                           <!-- <div class="tab_card">
                                                    <div class="card_top">
                                                        <h6>Day wise summary</h6>
                                                    </div>
                                                    <div class="dayWise_grid">
                                                        <div class="grid_row">
                                                            <div class="grid_item">
                                                                <div class="days_blck">
                                                                    <span>Day 1</span>
                                                                    <p>France</p>
                                                                </div>
                                                                <div class="details_blck">
                                                                    <div class="db_item">
                                                                        <img src="/images/tcHolidays/tc-PDP/hotels.svg"
                                                                            alt="" />
                                                                        <span>Hotel Clarion CDG / Moxy CDG / Ibis Styles
                                                                            CDG or similar in Paris (CDG Area),
                                                                            France.</span>
                                                                    </div>
                                                                    <div class="db_item">
                                                                        <img src="/images/tcHolidays/tc-PDP/meals-02.svg"
                                                                            alt="" />
                                                                        <span>Dinner</span>
                                                                    </div>
                                                                    <div class="db_item">
                                                                        <img src="/images/tcHolidays/tc-PDP/car.svg" alt="" />
                                                                        <span>Shared Airport transfers by a deluxe
                                                                            air-conditioned coach.</span>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="grid_item">
                                                                <div class="days_blck">
                                                                    <span>Day 2</span>
                                                                    <p>France</p>
                                                                </div>
                                                                <div class="details_blck">
                                                                    <div class="db_item">
                                                                        <img src="/images/tcHolidays/tc-PDP/hotels.svg"
                                                                            alt="" />
                                                                        <span>Hotel Clarion CDG / Moxy CDG / Ibis Styles
                                                                            CDG or similar in Paris (CDG Area),
                                                                            France.</span>
                                                                    </div>
                                                                    <div class="db_item">
                                                                        <img src="/images/tcHolidays/tc-PDP/camera-01.svg"
                                                                            alt="" />
                                                                        <ul>
                                                                            <li>Guided city tour of Paris</li>
                                                                            <li>Visit Fragonard</li>
                                                                            <li>Guided tour of Versailles Palace</li>
                                                                            <li>River Seine Cruise</li>
                                                                        </ul>
                                                                    </div>
                                                                    <div class="db_item">
                                                                        <img src="/images/tcHolidays/tc-PDP/meals-02.svg"
                                                                            alt="" />
                                                                        <span>Breakfast, Lunch, Dinner</span>
                                                                    </div>
                                                                    <div class="db_item">
                                                                        <img src="/images/tcHolidays/tc-PDP/car.svg" alt="" />
                                                                        <span>Shared transfers by a deluxe
                                                                            air-conditioned coach.</span>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="grid_row">
                                                            <div class="grid_item">
                                                                <div class="days_blck">
                                                                    <span>Day 3</span>
                                                                    <p>France</p>
                                                                </div>
                                                                <div class="details_blck">
                                                                    <div class="db_item">
                                                                        <img src="/images/tcHolidays/tc-PDP/hotels.svg"
                                                                            alt="" />
                                                                        <span>Hotel Clarion CDG / Moxy CDG / Ibis Styles
                                                                            CDG or similar in Paris (CDG Area),
                                                                            France.</span>
                                                                    </div>
                                                                    <div class="db_item">
                                                                        <img src="/images/tcHolidays/tc-PDP/camera-01.svg"
                                                                            alt="" />
                                                                        <ul>
                                                                            <li>Disneyland® Paris (01 Day 01 Park)</li>
                                                                            <li>Eiffel Tower (2nd Level)</li>
                                                                            <li>Illumination Tour</li>
                                                                        </ul>
                                                                    </div>
                                                                    <div class="db_item">
                                                                        <img src="/images/tcHolidays/tc-PDP/meals-02.svg"
                                                                            alt="" />
                                                                        <span>Breakfast, Dinner</span>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="grid_item">
                                                                <div class="days_blck">
                                                                    <span>Day 4</span>
                                                                    <p>Switzerland</p>
                                                                </div>
                                                                <div class="details_blck">
                                                                    <div class="db_item">
                                                                        <img src="/images/tcHolidays/tc-PDP/hotels.svg"
                                                                            alt="" />
                                                                        <span>Hotel Ibis Style / Harry's Home / Novotel
                                                                            Zurich Messe / Prizeotel Affoltern am Albis
                                                                            or similar in Basel / Zurich,
                                                                            Switzerland.</span>
                                                                    </div>
                                                                    <div class="db_item">
                                                                        <img src="/images/tcHolidays/tc-PDP/camera-01.svg"
                                                                            alt="" />
                                                                        <span>Scenic drive to Switzerland</span>
                                                                    </div>
                                                                    <div class="db_item">
                                                                        <img src="/images/tcHolidays/tc-PDP/meals-02.svg"
                                                                            alt="" />
                                                                        <span>Breakfast, Dinner</span>
                                                                    </div>
                                                                    <div class="db_item">
                                                                        <img src="/images/tcHolidays/tc-PDP/car.svg" alt="" />
                                                                        <span>Shared transfers by a deluxe
                                                                            air-conditioned coach.</span>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="grid_row">
                                                            <div class="grid_item">
                                                                <div class="days_blck">
                                                                    <span>Day 5</span>
                                                                    <p>Switzerland</p>
                                                                </div>
                                                                <div class="details_blck">
                                                                    <div class="db_item">
                                                                        <img src="/images/tcHolidays/tc-PDP/hotels.svg"
                                                                            alt="" />
                                                                        <span>Hotel Ibis Style / Harry's Home / Novotel
                                                                            Zurich Messe / Prizeotel Affoltern am Albis
                                                                            or similar in Basel / Zurich,
                                                                            Switzerland.</span>
                                                                    </div>
                                                                    <div class="db_item">
                                                                        <img src="/images/tcHolidays/tc-PDP/camera-01.svg"
                                                                            alt="" />
                                                                        <span>Day at Leisure</span>
                                                                    </div>
                                                                    <div class="db_item">
                                                                        <img src="/images/tcHolidays/tc-PDP/meals-02.svg"
                                                                            alt="" />
                                                                        <span>Breakfast, Dinner</span>
                                                                    </div>
                                                                    <div class="db_item">
                                                                        <img src="/images/tcHolidays/tc-PDP/car.svg" alt="" />
                                                                        <span>Shared transfers by a deluxe
                                                                            air-conditioned coach.</span>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="grid_item">
                                                                <div class="days_blck">
                                                                    <span>Day 6</span>
                                                                    <p>Switzerland</p>
                                                                </div>
                                                                <div class="details_blck">
                                                                    <div class="db_item">
                                                                        <img src="/images/tcHolidays/tc-PDP/hotels.svg"
                                                                            alt="" />
                                                                        <span>Hotel Coronado / Serpiano or similar in
                                                                            Mendriso / Serpiano, Switzerland.</span>
                                                                    </div>
                                                                    <div class="db_item">
                                                                        <img src="/images/tcHolidays/tc-PDP/camera-01.svg"
                                                                            alt="" />
                                                                        <ul>
                                                                            <li>Mt. Titlis</li>
                                                                            <li>Orientation tour of Lucerne</li>
                                                                        </ul>
                                                                    </div>
                                                                    <div class="db_item">
                                                                        <img src="/images/tcHolidays/tc-PDP/meals-02.svg"
                                                                            alt="" />
                                                                        <span>Breakfast, Dinner</span>
                                                                    </div>
                                                                    <div class="db_item">
                                                                        <img src="/images/tcHolidays/tc-PDP/car.svg" alt="" />
                                                                        <span>Shared transfers by a deluxe
                                                                            air-conditioned coach.</span>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="grid_row">
                                                            <div class="grid_item">
                                                                <div class="days_blck">
                                                                    <span>Day 7</span>
                                                                    <p>Italy</p>
                                                                </div>
                                                                <div class="details_blck">
                                                                    <div class="db_item">
                                                                        <img src="/images/tcHolidays/tc-PDP/hotels.svg"
                                                                            alt="" />
                                                                        <span>Hotel Park / President or similar in
                                                                            Arezzo, Italy.</span>
                                                                    </div>
                                                                    <div class="db_item">
                                                                        <img src="/images/tcHolidays/tc-PDP/camera-01.svg"
                                                                            alt="" />
                                                                        <ul>
                                                                            <li>Photo Stop at Lake Como</li>
                                                                            <li>Square of Miracles</li>
                                                                        </ul>
                                                                    </div>
                                                                    <div class="db_item">
                                                                        <img src="/images/tcHolidays/tc-PDP/meals-02.svg"
                                                                            alt="" />
                                                                        <span>Breakfast, Dinner</span>
                                                                    </div>
                                                                    <div class="db_item">
                                                                        <img src="/images/tcHolidays/tc-PDP/car.svg" alt="" />
                                                                        <span>Shared transfers by a deluxe
                                                                            air-conditioned coach.</span>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="grid_item">
                                                                <div class="days_blck">
                                                                    <span>Day 8</span>
                                                                    <p>Switzerland</p>
                                                                </div>
                                                                <div class="details_blck">
                                                                    <div class="db_item">
                                                                        <img src="/images/tcHolidays/tc-PDP/hotels.svg"
                                                                            alt="" />
                                                                        <span>Hotel Park / President or similar in
                                                                            Arezzo, Italy.</span>
                                                                    </div>
                                                                    <div class="db_item">
                                                                        <img src="/images/tcHolidays/tc-PDP/camera-01.svg"
                                                                            alt="" />
                                                                        <span>Guided tour of Rome and Vatican
                                                                            City</span>
                                                                    </div>
                                                                    <div class="db_item">
                                                                        <img src="/images/tcHolidays/tc-PDP/meals-02.svg"
                                                                            alt="" />
                                                                        <span>Breakfast, Lunch, Dinner</span>
                                                                    </div>
                                                                    <div class="db_item">
                                                                        <img src="/images/tcHolidays/tc-PDP/car.svg" alt="" />
                                                                        <span>Shared transfers by a deluxe
                                                                            air-conditioned coach.</span>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="grid_row">
                                                            <div class="grid_item">
                                                                <div class="days_blck">
                                                                    <span>Day 9</span>
                                                                    <p>Italy</p>
                                                                </div>
                                                                <div class="details_blck">
                                                                    <div class="db_item">
                                                                        <img src="/images/tcHolidays/tc-PDP/hotels.svg"
                                                                            alt="" />
                                                                        <span>Hotel AC by Marriott / Alfa Fiera / SHG
                                                                            Catullo or similar in Vicenza / Verona,
                                                                            Italy.</span>
                                                                    </div>
                                                                    <div class="db_item">
                                                                        <img src="/images/tcHolidays/tc-PDP/camera-01.svg"
                                                                            alt="" />
                                                                        <span>Orientation tour of Venice</span>
                                                                    </div>
                                                                    <div class="db_item">
                                                                        <img src="/images/tcHolidays/tc-PDP/meals-02.svg"
                                                                            alt="" />
                                                                        <span>Breakfast, Lunch, Dinner</span>
                                                                    </div>
                                                                    <div class="db_item">
                                                                        <img src="/images/tcHolidays/tc-PDP/car.svg" alt="" />
                                                                        <span>Shared transfers by a deluxe
                                                                            air-conditioned coach.</span>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="grid_item">
                                                                <div class="days_blck">
                                                                    <span>Day 10</span>
                                                                    <p>Germany</p>
                                                                </div>
                                                                <div class="details_blck">
                                                                    <div class="db_item">
                                                                        <img src="/images/tcHolidays/tc-PDP/hotels.svg"
                                                                            alt="" />
                                                                        <span>Holiday Inn express / Flightgate Munich
                                                                            Airport / Amedia Dachau or similar in
                                                                            Munich, Germany.</span>
                                                                    </div>
                                                                    <div class="db_item">
                                                                        <img src="/images/tcHolidays/tc-PDP/camera-01.svg"
                                                                            alt="" />
                                                                        <ul>
                                                                            <li>Orientation tour of Innsbruck</li>
                                                                            <li>Swarovski Crystal Worlds</li>
                                                                        </ul>
                                                                    </div>
                                                                    <div class="db_item">
                                                                        <img src="/images/tcHolidays/tc-PDP/meals-02.svg"
                                                                            alt="" />
                                                                        <span>Breakfast, Lunch, Dinner</span>
                                                                    </div>
                                                                    <div class="db_item">
                                                                        <img src="/images/tcHolidays/tc-PDP/car.svg" alt="" />
                                                                        <span>Shared transfers by a deluxe
                                                                            air-conditioned coach.</span>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="grid_row">
                                                            <div class="grid_item">
                                                                <div class="days_blck">
                                                                    <span>Day 11</span>
                                                                    <p>Italy</p>
                                                                </div>
                                                                <div class="details_blck">
                                                                    <div class="db_item">
                                                                        <img src="/images/tcHolidays/tc-PDP/hotels.svg"
                                                                            alt="" />
                                                                        <p>(NA)</p>
                                                                    </div>
                                                                    <div class="db_item">
                                                                        <img src="/images/tcHolidays/tc-PDP/camera-01.svg"
                                                                            alt="" />
                                                                        <p>(NA)</p>
                                                                    </div>
                                                                    <div class="db_item">
                                                                        <img src="/images/tcHolidays/tc-PDP/meals-02.svg"
                                                                            alt="" />
                                                                        <span>Breakfast</span>
                                                                    </div>
                                                                    <div class="db_item">
                                                                        <img src="/images/tcHolidays/tc-PDP/car.svg" alt="" />
                                                                        <span>Shared transfers by a deluxe
                                                                            air-conditioned coach.</span>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>  -->
                                            </div>
                                        </div>
                                    </div>




                                    <div class="tab-pane fade" id="nav-highlights" role="tabpanel" aria-labelledby="nav-highlights-tab">
    <div class="tab-container tab_highlights"  v-if="packageDetailsResponse?.[0]?.packageDetail?.overviewHighlights">
        <div class="tab-right">
            <div class="tab_card">
                <div class="card_top">
                    <h6>Highlights</h6>
                </div>
                <div class="highlights_grid">
                    <!-- Dynamic highlights from API -->
                    <span>
                        <div class="grid_items">
                            <div class="icon">
                                <img src="/images/tcHolidays/tc-PDP/polygon.svg" alt="" />
                            </div>
                            <div v-html="packageDetailsResponse[0].packageDetail.overviewHighlights"></div>
                        </div>
                    </span>

                    <!-- Fallback static highlights if no API data -->
                   
                </div>
            </div>
        </div>
    </div>
</div>
                                   
                                    <!-- <div class="tab-pane fade" id="nav-highlights" role="tabpanel"
                                        aria-labelledby="nav-highlights-tab">
                                        <div class="tab-container tab_highlights">
                                            <div class="tab-right">
                                                <div class="tab_card">
                                                    <div class="card_top">
                                                        <h6>Highlights</h6>
                                                    </div>
                                                    <div class="highlights_grid">
                                                        <div class="grid_items">
                                                            <div class="icon">
                                                                <img src="/images/tcHolidays/tc-PDP/polygon.svg" alt="" />
                                                            </div>
                                                            <span>Direct Flight from Ahmedabad</span>
                                                        </div>

                                                        <div class="grid_items">
                                                            <div class="icon">
                                                                <img src="/images/tcHolidays/tc-PDP/polygon.svg" alt="" />
                                                            </div>
                                                            <span>Specially Curated menu for our Gujrati and Jain Guest
                                                                by Gujrati Chef</span>
                                                        </div>

                                                        <div class="grid_items">
                                                            <div class="icon">
                                                                <img src="/images/tcHolidays/tc-PDP/polygon.svg" alt="" />
                                                            </div>
                                                            <span>Special Masala Chai Every Morning</span>
                                                        </div>

                                                        <div class="grid_items">
                                                            <div class="icon">
                                                                <img src="/images/tcHolidays/tc-PDP/polygon.svg" alt="" />
                                                            </div>
                                                            <span>River Side Lunch at Punakha</span>
                                                        </div>

                                                        <div class="grid_items">
                                                            <div class="icon">
                                                                <img src="/images/tcHolidays/tc-PDP/polygon.svg" alt="" />
                                                            </div>
                                                            <span>Farmhouse lunch with activities (Archery/ Go and Kira
                                                                Local dress)</span>
                                                        </div>

                                                        <div class="grid_items">
                                                            <div class="icon">
                                                                <img src="/images/tcHolidays/tc-PDP/polygon.svg" alt="" />
                                                            </div>
                                                            <span>Farewell Dinner at Thimphu followed by Cultural Show,
                                                                Bonfire and Light music</span>
                                                        </div>

                                                        <div class="grid_items">
                                                            <div class="icon">
                                                                <img src="/images/tcHolidays/tc-PDP/polygon.svg" alt="" />
                                                            </div>
                                                            <span>Daily Snacks as per itinerary</span>
                                                        </div>

                                                        <div class="grid_items">
                                                            <div class="icon">
                                                                <img src="/images/tcHolidays/tc-PDP/polygon.svg" alt="" />
                                                            </div>
                                                            <span>Gujrati Speaking Experience Manager Ex
                                                                Ahmedabad</span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div> -->
                                
                                </div>